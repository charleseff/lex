require File.dirname(__FILE__) + '/../test_helper'

class ConfirmationCodeTest < Test::Unit::TestCase
  fixtures :confirmation_codes, :users

  def test_date_is_attached_to_new_confirmation_code
    confirmation_code = ConfirmationCode.new(:task => 'reset_password', :user_id => users(:bobby).id )
    assert_nil  confirmation_code.created_at
    confirmation_code.save!
    assert_not_nil confirmation_code.created_at

  end
end
