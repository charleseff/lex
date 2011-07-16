require "#{File.dirname(__FILE__)}/../test_helper"

class LoginTest < ActionController::IntegrationTest

  fixtures :users

  def setup
    super
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @emails     = ActionMailer::Base.deliveries
    @emails.clear
  end


  def test_successful_student_login
    user = users(:bobby)
    post_via_redirect login_path, :email => user.email, :password => 'barrel'
    assert_match /Hello,/, @response.body
  end


=begin



  def test_successful_student_login
    user = users(:bobby)
    get login_path, :protocol => 'https://'
#    get 'login', :protocol => 'https://'
#    get :controller => 'account', :action => 'login', :protocol => 'https://'
#    post login_path, :protocol => "https", :email => user.email, :password => 'barrel'
#    post_via_redirect login_path, :protocol => "https", :email => user.email, :password => 'barrel'
    assert_match /Hello,/, @response.body
  end

=end



end
