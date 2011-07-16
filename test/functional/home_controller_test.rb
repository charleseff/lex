require File.dirname(__FILE__) + '/../test_helper'
require 'home_controller'

# Re-raise errors caught by the controller.
class HomeController; def rescue_action(e) raise e end; end

class HomeControllerTest < Test::Unit::TestCase

  fixtures :users

  def setup
    super
    @controller = HomeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_no_one_logged_on_goes_to_default_index
    get :index
    assert_redirected_to login_path
  end

  def test_student_logged_on_goes_to_student_home
    login_as :bobby

    get :index
    assert_response :success


  end
end
