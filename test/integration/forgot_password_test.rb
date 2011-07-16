require "#{File.dirname(__FILE__)}/../test_helper"

class ForgotPasswordTest < ActionController::IntegrationTest

  fixtures :users

  def setup
    super
    @emails     = ActionMailer::Base.deliveries
    @emails.clear
  end


  def test_forgot_password_use_case_works
    user = users(:bobby)
    old_password = user.password
    password = 'foood'

    post_via_redirect '/account/forgot_password', :email => user.email
    assert_tag :content => /.*follow the link to reset your password.*/
    assert_equal(1, @emails.size)

    email = @emails.first
    confirm_code = email.body.scan(/reset_password\/(.*)$/)[0][0]
    get_via_redirect '/account/reset_password', :id => confirm_code
    # todo: assert user is at the reset password page now
    ##
    post_via_redirect '/account/reset_password', {:id => confirm_code, :password => password, :password_confirmation => password}

    #todo: ok for some reason the following line is not asserting even though the string looks like it's correct.  commenting out for now:
    # due to a bug in rails: see "Integration tests" at: http://wiki.pragmatus.com/index.php?title=Test_Driven_Development_with_Ruby
    assert_match /have successfully changed your password/, @response.body

    post_via_redirect '/account/login', :email => user.email, :password => password
    assert_match /Welcome/, @response.body

  end



end
