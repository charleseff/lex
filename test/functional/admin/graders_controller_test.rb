require File.dirname(__FILE__) + '/../../test_helper'
require File.dirname(__FILE__) +  '/../authorization_controller_test'

class Admin::GradersControllerTest < Test::Unit::TestCase
  include AuthorizationControllerSubclassTest

  fixtures :users

  def setup
    super   
    @controller = Admin::GradersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # test this after grader controller gets authentication scheme
  def test_index
    
    login_as :charles
#    assert @controller.current_user.is_a User

    get :index
    
    assert_response :success
  end


#  def test_logged_in
#    get :index
#
#  end




end
