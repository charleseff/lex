require "#{File.dirname(__FILE__)}/../test_helper"

class SignupTest < ActionController::IntegrationTest

  fixtures :key_value_pairs

  def setup
    super
    @emails     = ActionMailer::Base.deliveries
    @emails.clear
  end


  def test_signup_and_enter_confirmation_code_works
#    create_student
    post '/account/student_enter_passcode', :passcode => 'passcode'
    post_via_redirect '/account/student_signup', :user => { :email => 'quire@example.com',
            :password => 'quire', :password_confirmation => 'quire', :first_name => 'Charles',
            :last_name => 'Smith', :grade_level_form_value => 1, :birth_date => Time.now }
    assert_match /you have one more step before completing your registration.  Please check your email and follow the link to activate your account/, @response.body
    assert_equal(1, @emails.size)

    email = @emails.first
    confirm_code = email.body.scan(/confirm\/(.*)$/)[0][0]
    get_via_redirect '/account/confirm', :id => confirm_code
    assert_tag :content => /.*Congratulations.*/
    assert_match /Welcome/, @response.body
  end

  def test_signup_fails_using_a_yahoo_co_kr_account
    post '/account/student_enter_passcode', :passcode => 'passcode'
    post_via_redirect '/account/student_signup', :user => { :email => 'quire@yahoo.co.kr',
            :password => 'quire', :password_confirmation => 'quire', :first_name => 'Charles',
            :last_name => 'Smith', :grade_level_form_value => 1, :birth_date => Time.now }
#    puts @response.body
    assert_match /Please do not use email accounts from yahoo.co.kr/, @response.body

  end

end
