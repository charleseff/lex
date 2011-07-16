require File.dirname(__FILE__) + '/../test_helper'

class EmailChangeRequestTest < Test::Unit::TestCase
  fixtures :email_change_requests

  def test_truth
    assert true
  end

# todo: comment out for now:
=begin
  def test_ensure_user_can_only_attempt_an_email_address_change_once
    assert false
  end
=end

end
