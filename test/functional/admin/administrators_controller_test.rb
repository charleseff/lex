require File.dirname(__FILE__) + '/../../test_helper'
require File.dirname(__FILE__) +  '/../authorization_controller_test'

class Admin::AdministratorsControllerTest < Test::Unit::TestCase
  include AuthorizationControllerSubclassTest
  #class AdministratorControllerTest < AuthorizationControllerTest

  fixtures :users
  
  def setup
    super
    @controller = Admin::AdministratorsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_redirect_to_login
    
    get :index
    assert_response 302
    assert_redirected_to login_path
    assert_template nil
  end
  
  def test_works_after_admin_logs_in
    login_as :charles
    get :index
    assert_response :success
    assert_response 200
    
#    assert_template "../../vendor/plugins/active_scaffold/frontends/default/views/list"
    assert_tag :content => "Administrators Admin Page"
    
  end


  
end
