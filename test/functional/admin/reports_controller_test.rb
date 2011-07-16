require File.dirname(__FILE__) + '/../../test_helper'
require File.dirname(__FILE__) +  '/../authorization_controller_test'

class Admin::ReportsControllerTest < Test::Unit::TestCase
  include AuthorizationControllerSubclassTest

  fixtures :reports
  fixtures :users

  def setup
    super   
    @controller = Admin::ReportsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_page_comes_up
    login_as :charles
    get :index
    
    assert_response :success
  end

  def test_new_report_gets_current_time

  end

end
