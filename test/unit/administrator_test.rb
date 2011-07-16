require File.dirname(__FILE__) + '/../test_helper'

class AdministratorTest < Test::Unit::TestCase
  fixtures :users

  def test_get_administrator_by_email
    charles = User.find_by_email('charles.finkel@gmail.com')
    # charles is an administrator, not a student:
    assert_not_nil charles
    assert_equal charles.class, Administrator
  end

end
