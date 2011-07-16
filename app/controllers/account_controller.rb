# this class is too long, should DRY a bit..
class AccountController < ApplicationController
  layout "minimized"

  ssl_require_all

  before_filter :ensure_user_not_logged_in, :only => [:student_signup_auth, :student_enter_passcode,
      :grader_enter_passcode, :grader_signup_auth, :student_signup, :grader_signup]
  before_filter :ensure_user_logged_in, :only => [:settings, :change_password, :change_email_request]

  %w(student grader).each do |type|
    eval "before_filter :check_#{type}_correctly_entered_passcode, :only => :#{type}_signup"
  end

  %w(student grader).each do |type|
    eval <<END
  def #{type}_enter_passcode
    if Digest::SHA1.hexdigest( params[:passcode] ) ==
        KeyValuePair.find_by_k('new_#{type}_passcode').v
      session[:correctly_entered_new_#{type}_passcode] = true
      redirect_to :controller => :account, :action => :#{type}_signup
    else
      @error = 'Passcode is incorrect.  Please try again.'
      render :action => :#{type}_signup_auth
    end
  end

  def check_#{type}_correctly_entered_passcode
    if session[:correctly_entered_new_#{type}_passcode].nil?
      flash[:error] = 'You have not correctly entered the passcode.'
      redirect_to :controller => :account, :action => :#{type}_signup_auth
      return false
    end
  end

  def #{type}_signup
    unless request.post?
      @user = #{type.capitalize}.new
      return
    end

    @errors = []
    if params[:user].select{|p0,p1| p0  =~ /birth_date/}.any?{|p0, p1| p1 == ''}
      @errors << 'You must enter a correct value for your birthday'
    end

    @user = #{type.capitalize}.new( params[:user])
    unless @user.valid?
      @errors += @user.errors.full_messages
    end

    if not @errors.empty?
      render :template => 'account/#{type}_signup'
    else
      @user.save!
      confirmation_code = ConfirmationCode.new( {:task => 'signup', :user => @user} )
      confirmation_code.save!
      Mailers::AccountMailer.deliver_new_user(@user, confirmation_code, Time.now)
      flash[:message] = @user.first_name + ", you have one more step before completing your registration.  Please check your email and follow the link to activate your account."
      redirect_to :controller => :account, :action => :message_no_links
    end
  end
END
  end

  def settings
    if request.post?
      current_user.update_attributes!(params[:current_user])
      @update_notice = "Account updated."
    end
    render :action => "#{current_user.class.to_s.downcase}_settings"
  rescue
    @errors = current_user.errors.full_messages
    render :action => "#{current_user.class.to_s.downcase}_settings"
  end

  def change_password
    @errors = []
    if not request.post?
      redirect_to root_path
      return
    end
    if params[:current_user][:password] == ''
      @errors << "Your password can't be blank"
    elsif current_user.update_attributes(params[:current_user])
      @notice = "Account updated."
    else
      @errors = current_user.errors.full_messages
    end
    render :action => "#{current_user.class.to_s.downcase}_settings"

  end

  def change_email_request
    redirect_to root_path unless request.post?
    new_email = params[:current_user][:email]
    if  (not new_email =~ User::EMAIL_VALIDATION_REGEX)
      @error = "Email is not a valid email address"
    elsif new_email == current_user.email
      @error = "You must choose a different email address from your own"
    elsif User.find_by_email(new_email)
      @error = "That email address already exists in the system.  Please choose a diferent email address"
    else
      email_change_request = EmailChangeRequest.new({:user => current_user, :email => new_email})
      email_change_request.save!
      Mailers::AccountMailer.deliver_change_email_request(@student, email_change_request, Time.now)
      @notice = "You have requested to change your email address to #{new_email}." +
          "  Please check your email at #{new_email} and follow the link to make the change."
    end
    render :action => "#{current_user.class.to_s.downcase}_settings"
  end

  def change_email
    # for changing the email after user clicked email link:
    # check for code in id:
    email_change_request = EmailChangeRequest.find_by_confirmation_code(params[:id] )
    if email_change_request.nil?
      redirect_to root_path
      return false
    end
    user = email_change_request.user
    user.email = email_change_request.email
    user.save!
    current_user = user
    EmailChangeRequest.delete(email_change_request)
    @notice = "You have successfully changed your email address to #{user.email}!"
    render :controller => :account, :action => :message
  end

  def login
    if current_user != :false
      redirect_to root_path
      return
    end
    return unless request.post?
    self.current_user = User.authenticate(params[:email], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end

      redirect_back_or_default(root_path)
    else
      @error = "Login failed. Please try again."
    end
  end

  def forgot_password
    return unless request.post?
    user = User.find_by_email(params[:email])
    if user == nil
      @error = "That email address does not exist in the Lex Kim Book Reports system."
      return false
    end
    confirmation_code = ConfirmationCode.new( {:task => 'reset_password', :user => user} )
    confirmation_code.save!
    Mailers::AccountMailer.deliver_reset_password_request(user, confirmation_code, Time.now)
    flash[:notice] = "OK!  An email was sent to your email address at #{params[:email]}.  Please check your email and " +
        "follow the link to reset your password."
    redirect_to login_path
  end

  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(root_path)
  end
  def ensure_user_not_logged_in
    if current_user.is_a? User
      flash[:error] = "You must be logged out to do that"
      redirect_to root_path
      return false
    end
  end

  def confirm
    confirmation_code = ConfirmationCode.find(:first, :conditions => {:code => params[:id], :task => 'signup'} )
    if confirmation_code.nil?
      redirect_to root_path
      return false
    end
    user = confirmation_code.user
    user.confirmed = true
    user.save!
    ConfirmationCode.delete(confirmation_code)
    self.current_user = user
    flash[:notice] = "Congratulations #{user.first_name}, your account is now activated!"
    redirect_to root_path
  end

  def reset_password
    confirmation_code = ConfirmationCode.find(:first, :conditions => {:code => params[:id], :task => 'reset_password'} )
    if confirmation_code.nil?
      redirect_to root_path
      return false
    end
    return unless request.post?

    user = confirmation_code.user
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
    if user.valid?
      user.save!
      ConfirmationCode.delete(confirmation_code)
      flash[:notice] = "You have successfully changed your password!  Now use your new password to login."
      redirect_to login_path
    else
      @errors = user.errors.full_messages
    end
  end

  # just for test:
  def test_error
    just_a.test_exception
  end

  private
  def ensure_user_logged_in
    if not current_user.is_a? User
      redirect_to root_path
      return false
    end
  end

end
