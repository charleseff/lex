require File.dirname(__FILE__) + '/../test_helper'

class StudentTest < Test::Unit::TestCase
  fixtures :users, :reports

  # this test is really very general, for any activerecord table:
  def test_nonexistence
    record_not_found = false
    begin
      not_there = User.find(999999999)
    rescue ActiveRecord::RecordNotFound
      record_not_found = true
    end
    assert record_not_found
  end

  def test_get_student_by_email
    bobby = User.find_by_email('bobby@example.com')
    assert_not_nil bobby
    assert_equal bobby.class, Student
    assert_equal bobby.grade_level.level, 4
    assert_equal bobby.birth_date.year, 10.years.ago.year
  end

  def test_get_active_and_inactive_reports
    bobby = users(:bobby)

    assert_equal  8, bobby.reports.size
    assert_equal  1, bobby.inactive_reports.size
    assert_equal  7, bobby.active_reports.size
  end

  def test_graded_and_assignededness_of_reports
    bobby =  users(:bobby)

    assert_equal 1, bobby.reports_not_assigned_to_a_grader.size

    assert_equal 2, bobby.graded_but_still_active_reports.size
    assert_equal 4, bobby.reports_assigned_to_a_grader_but_ungraded.size

    assert_equal bobby.active_reports.to_set ,
            (bobby.reports_not_assigned_to_a_grader +
                    bobby.graded_but_still_active_reports +
                    bobby.reports_assigned_to_a_grader_but_ungraded).to_set
  end

end
