require File.dirname(__FILE__) + '/../test_helper'

class ReportTest < Test::Unit::TestCase
  fixtures :reports
  fixtures :books
  fixtures :users

  def test_file_type
    report_file = File.open("#{RAILS_ROOT}/test/fixtures/Grapes_of_Wrath_by_Bobby.doc", 'rb')
  end

  def test_report_exists
    bobby_report = reports(:bobby_report_graded_by_sean)
    bessy_report = reports(:bessy_report)

    assert bobby_report.graded?
    assert bobby_report.has_grader?

    assert (not bessy_report.graded?)
    assert (not bessy_report.has_grader?)

  end

  def test_report_that_has_grader_but_not_yet_graded
    ready_to_be_dropped_report = reports(:ready_to_be_dropped_report)
    assert ready_to_be_dropped_report.has_grader?
    assert (not ready_to_be_dropped_report.graded?)
  end

  def test_get_unassigned_reports
    unassigned_reports = Report.unassigned_reports
    assert_equal 2, unassigned_reports.size
  end

  def test_get_report_to_label
    bobby_report = reports(:bobby_report_graded_and_inactive)
    assert_equal "report on 'Book 3' by Bobby K.", bobby_report.to_label
  end

  def test_invalidity_of_ptal_data
    invalid_report = reports(:bobby_report_assigned_to_but_ungraded_by_sean)
    assert (not invalid_report.graded_ptal_task_items_data_is_valid)
  end

  def test_validity_of_ptal_data
    valid_report = reports(:bobby_report_graded_by_sean)
    assert valid_report.graded_ptal_task_items_data_is_valid
  end

end
