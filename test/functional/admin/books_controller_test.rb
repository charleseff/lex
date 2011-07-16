require File.dirname(__FILE__) + '/../../test_helper'
require File.dirname(__FILE__) +  '/../authorization_controller_test'


class Admin::BooksControllerTest < Test::Unit::TestCase
  include AuthorizationControllerSubclassTest
  
  def setup
    super   
    @controller = Admin::BooksController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
