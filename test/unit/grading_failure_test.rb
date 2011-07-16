require File.dirname(__FILE__) + '/../test_helper'

class FailuresToGradeTest < Test::Unit::TestCase
  fixtures :grading_failures, :reports, :users

  # Replace this with your real tests.
  def test_that_they_exist
    report = reports(:bobby_report_no_grader)
    assert_equal 2, report.grading_failures.size
  end

  def test_failed_to_grade
    sean = users(:sean)
    report = reports(:bobby_report_no_grader)
    assert (sean.failed_to_grade report)
    assert (users(:kate).failed_to_grade report)
    assert (not users(:donna).failed_to_grade report)
  end
  
end
