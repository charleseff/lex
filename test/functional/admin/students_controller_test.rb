require File.dirname(__FILE__) + '/../../test_helper'
require File.dirname(__FILE__) +  '/../authorization_controller_test'

class Admin::StudentsControllerTest < Test::Unit::TestCase
  include AuthorizationControllerSubclassTest

  def setup
    super   
    @controller = Admin::StudentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end


  def test_redirect_if_not_logged_on
    get :index
    assert_response 302
  end
end
