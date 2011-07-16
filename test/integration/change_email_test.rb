require "#{File.dirname(__FILE__)}/../test_helper"

class ChangeEmailTest < ActionController::IntegrationTest

  fixtures :users

  def setup
    super
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @emails     = ActionMailer::Base.deliveries
    @emails.clear
  end

  def test_change_email_address_invalid_email
    user = users(:quentin)
    post_via_redirect login_path, :email => user.email, :password => 'test', :protocol => "https://"
    post_via_redirect '/account/change_email_request', :current_user => {:email => 'bad_email_address'}
    assert_match /Email is not a valid email address/, @response.body
  end

  def test_change_email_address_doesnt_work_when_using_same_email
    user = users(:quentin)
    post_via_redirect login_path, :email => user.email, :password => 'test', :protocol => "https://"
    post_via_redirect '/account/change_email_request', :current_user => {:email => user.email}
    assert_match /You must choose a different email address from your own/, @response.body
  end

  def test_change_email_address_doesnt_work_when_using_preexisting_email
    user = users(:quentin)
    other_user_email = users(:aaron).email
    post_via_redirect login_path, :email => user.email, :password => 'test', :protocol => "https://"
    post_via_redirect '/account/change_email_request', :current_user => {:email => other_user_email}
    assert_match /That email address already exists in the system.  Please choose a diferent email address/, @response.body
  end

  # todo: I GIVE UP for now... ARGH
  #  def test_change_email_address
  #
  #=begin
  #
  #    user = users(:sean)
  #    post_via_redirect '/account/login', :email => user.email, :password => 'barrel'
  #    assert_match /You are currently logged in as user/, @response.body
  #
  #=end
  #
  #
  #    login_as :sean
  #
  #    email_address = 'email_address@test.com'
  #    post_via_redirect '/account/change_email', :current_user => {:email => email_address}
  #    assert_match /You have requested to change your email address/, @response.body
  ##    login_as :charles
  #    assert true
  #  end

end
