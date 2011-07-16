require File.dirname(__FILE__) + '/../test_helper'

class GradeLevelTest < Test::Unit::TestCase
  fixtures :grade_levels, :ptal_task_items

  # Replace this with your real tests.
  def test_truth
    assert true
  end

  def test_categories
    grade_level = grade_levels(:grade_level_1)

    assert_equal 4, grade_level.ptal_categories.size
    assert_equal 5, grade_level.ptal_categories['A. Structure'][:task_items].size
    assert_equal 4, grade_level.ptal_categories['B. Content'][:task_items].size
    assert_equal 3, grade_level.ptal_categories['C. Style'][:task_items].size
    assert_equal 3, grade_level.ptal_categories['D. Mechanics'][:task_items].size

    assert_equal 50, grade_level.total_possible_points
  end
end
