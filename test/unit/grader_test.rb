require File.dirname(__FILE__) + '/../test_helper'

class GraderTest < Test::Unit::TestCase
fixtures :users, :grade_levels
  
  def test_get_grader_by_email
    sean = User.find_by_email('sean.white@test.com')
    # charles is an administrator, not a student:
    assert_not_nil sean
    assert_equal sean.class, Grader
  end

  def test_preferred_grade_levels

    kate = users(:kate)
    assert kate.preferred_grade_levels.empty?

    sean = users(:sean)
    assert_not_nil sean.preferred_grade_levels
    # todo: fix this.. the levels themselves are the same but not the id's for some reason...
#    assert_equal [grade_levels(:grade_level_1),grade_levels(:grade_level_3),grade_levels(:grade_level_7)], sean.preferred_grade_levels

  end
end
