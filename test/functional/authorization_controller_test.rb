require File.dirname(__FILE__) + '/../test_helper'
require 'authorization_controller'

# Re-raise errors caught by the controller.
class AuthorizationController; def rescue_action(e) raise e end; end

class AuthorizationControllerTest < Test::Unit::TestCase

  def setup
    super
    @controller = AuthorizationController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end

end

module AuthorizationControllerSubclassTest
  def test_allowed_users_are_right_type
    # assert_equal   @controller.class, AuthorizationController
    if not @controller.class == AuthorizationController
      assert_equal @controller.send('allowed_users').class, Set
      @controller.send('allowed_users').each  do |user_type|
        assert_equal user_type.superclass, User
      end
    end
  end

end
