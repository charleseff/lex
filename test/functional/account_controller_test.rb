require File.dirname(__FILE__) + '/../test_helper'
require 'account_controller'
 
# Re-raise errors caught by the controller.
class AccountController; def rescue_action(e) raise e end; end

class AccountControllerTest < Test::Unit::TestCase

  fixtures :key_value_pairs, :users

  def setup
    @controller = AccountController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :login, :email => 'quentin@example.com', :password => 'test'
    assert_response :redirect
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:user_id]
    assert_response :redirect
  end

  def test_should_remember_me
    post :login, :email => 'quentin@example.com', :password => 'test', :remember_me => "1"
    assert_not_nil @response.cookies["auth_token"]
  end

  def test_should_not_remember_me
    post :login, :email => 'quentin@example.com', :password => 'test', :remember_me => "0"
    assert_nil @response.cookies["auth_token"]
  end

  def test_should_delete_token_on_logout
    login_as :quentin
    get :logout
    assert_equal @response.cookies["auth_token"], []
  end

  def test_should_login_with_cookie
    users(:quentin).remember_me
    @request.cookies["auth_token"] = cookie_for(:quentin)
    get :settings
    assert @controller.send(:logged_in?)
  end

  def test_should_fail_expired_cookie_login
    users(:quentin).remember_me
    users(:quentin).update_attribute :remember_token_expires_at, 5.minutes.ago
    @request.cookies["auth_token"] = cookie_for(:quentin)
    get :settings
    assert !@controller.send(:logged_in?)
  end

  def test_should_fail_cookie_login
    users(:quentin).remember_me
    @request.cookies["auth_token"] = auth_token('invalid_auth_token')
    get :settings
    assert !@controller.send(:logged_in?)
  end

  protected
    def auth_token(token)
      CGI::Cookie.new('name' => 'auth_token', 'value' => token)
    end

    def cookie_for(user)
      auth_token users(user).remember_token
    end
=begin


  def setup
    super
    @controller = AccountController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @emails     = ActionMailer::Base.deliveries
    @emails.clear
  end

  def test_should_login_and_redirect
    post :login, :email => 'quentin@example.com', :password => 'test'
    assert session[:user]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :email => 'quentin@example.com', :password => 'bad password'
    assert_nil session[:user]
    assert_response :success
  end

  def test_should_allow_signup
    assert_difference Student, :count do
      create_student
      assert_response :redirect
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference User, :count do
      create_student(:password => nil)
      assert assigns(:student).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference User, :count do
      create_student(:password_confirmation => nil)
      assert assigns(:student).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference User, :count do
      create_student(:email => nil)
      assert assigns(:student).errors.on(:email)
      assert_response :success
    end
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:user]
    assert_response :redirect
  end

  def test_should_remember_me
    post :login, :email => 'quentin@example.com', :password => 'test', :remember_me => "1"
    assert_not_nil @response.cookies["auth_token"]
  end

  def test_should_not_remember_me
    post :login, :email => 'quentin@example.com', :password => 'test', :remember_me => "0"
    assert_nil @response.cookies["auth_token"]
  end

  def test_should_delete_token_on_logout
    login_as :quentin
    get :logout
    assert_equal @response.cookies["auth_token"], []
  end

  #todo: dunno why:

=end

=begin
def test_should_login_with_cookie
    users(:quentin).remember_me
    @request.cookies["auth_token"] = cookie_for(:quentin)
    get :settings
    assert @controller.send(:logged_in?)
  end
=end


=begin

 def test_should_fail_expired_cookie_login
    users(:quentin).remember_me
    users(:quentin).update_attribute :remember_token_expires_at, 5.minutes.ago
    @request.cookies["auth_token"] = cookie_for(:quentin)
    get :settings
    assert !@controller.send(:logged_in?)
  end

  def test_should_fail_cookie_login
    users(:quentin).remember_me
    @request.cookies["auth_token"] = auth_token('invalid_auth_token')
    get :settings
    assert !@controller.send(:logged_in?)
  end


  #  CF tests starting here
  def test_manual_post_of_fields
    charles = users(:charles)
    post :login,  :email => charles.email, :password => 'barrel'
    assert_redirected_to :action => "index", :controller => "home"
  end

  def test_ensure_student_and_grader_get_mail_at_signup
    assert_equal(0, @emails.size)
    create_student
    assert_equal(1, @emails.size)
  end

  def test_ensure_grader_gets_mail_at_signup
    create_grader
    assert_equal(1, @emails.size)
  end

  def test_ensure_student_cant_signup_if_logged_on
    login_as :sean
    create_student
    assert_redirected_to root_path
  end

  def test_ensure_no_user_is_logged_in_and_new_user_cant_login_immediately_after_signup
    create_student
    assert (not @controller.send(:logged_in?))
    post :login, :email => 'quire@example.com', :password => 'quire'

    assert_response :success
    assert_tag :content => /.*Login failed.*/
  end

  def test_change_email_fails_for_invalid_email_address
    login_as :charles
    post :change_email, :current_user => {:email => 'bad_email_address'}
    assert_redirected_to :action=>:settings
  end

  def test_change_email_succeeds_for_valid_email_address
    login_as :charles
    post :change_email, :current_user => {:email => 'bad_email_address'}
    assert_redirected_to :action=>:settings
  end

  def test_creating_student_has_korea_timezone_default
create_student
    student = Student.find(:first, :conditions => {:email => 'quire@example.com'})
    assert_not_nil student
    assert_equal 'Seoul', student.time_zone
  end

  def test_creating_grader_has_eastern_timezone_default
    create_grader
    grader = Grader.find(:first, :conditions => {:email => 'quire2@example.com'})
    assert_not_nil grader
    assert_equal 'Eastern Time (US & Canada)', grader.time_zone
  end

  protected
  def create_student(options = {})
    # first must enter initial signup screen:
    post :student_enter_passcode, :passcode => 'passcode'

    post :student_signup, :student => { :email => 'quire@example.com',
            :password => 'quire', :password_confirmation => 'quire', :first_name => 'Charles', :last_name => 'Smith', :grade_level => 1, :birth_date => Time.now }.merge(options)
  end

  def create_grader(options = {})
    # first must enter initial signup screen:
    post :grader_enter_passcode, :passcode => 'passcode'

    post :grader_signup, :grader => { :email => 'quire2@example.com',
            :password => 'quire2', :password_confirmation => 'quire2', :first_name => 'Charlese', :last_name => 'Smithe' }.merge(options)
    assert_redirected_to :controller => :account, :action => :message
#    assert_tag :content => /.*you have one more step before completing your registration.*/
  end

  def auth_token(token)
    CGI::Cookie.new('name' => 'auth_token', 'value' => token)
  end

  def cookie_for(user)
    auth_token users(user).remember_token
  end

=end

end
