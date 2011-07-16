require File.dirname(__FILE__) + '/../test_helper'

class CronRunnerTest < Test::Unit::TestCase
  fixtures :reports, :users, :books

  def setup
    super
    @emails     = ActionMailer::Base.deliveries
    @emails.clear
  end

  def test_grader_gets_warning
    assert_equal(0, @emails.size)
    report = reports(:bobby_report_ready_for_warning)
    assert (not report.grader_was_warned)

    #  GradingStatusCheckerWorker.new.do_work
    CronRunner.warn_graders

    report.reload
    assert (report.grader_was_warned)
    assert_equal(2, @emails.size)
    email = @emails.first
    assert_match /You have approximately #{report.hours_left_before_grading_due.to_i} hours left to grade the report assigned to you/, email.body

    email = @emails[1]
    assert_match /The system has detected that the following graders are close to the due date for grading their reports, and has sent out email warnings/, email.body
    assert_equal email.to, APP_CONFIG['admin_emails']
  end

  def test_grader_thats_past_3_days_but_not_past_23_59_of_that_doesnt_get_booted
    report = reports(:report_over_3_days_graded_but_not_yet_23_59_of_that_day)
    grader = report.grader
    assert (not grader.can_grade_another_report)
    assert report.grader_was_warned
    assert (not report.grader.nil?)

    CronRunner.drop_graders

    report.reload
    assert (not report.grader.nil?)

  end

  def test_grader_gets_booted
    report = reports(:ready_to_be_dropped_report)
    grader = report.grader
    assert (not grader.can_grade_another_report)
    assert report.grader_was_warned
    assert (not report.grader.nil?)

    CronRunner.drop_graders

    report.reload
    assert report.grader.nil?
    assert (not report.grader_was_warned)

    assert_equal(3, @emails.size)
    email = @emails[0]
    assert_match /The system has detected the following graders to have surpassed the allotted time to grade their report/, email.body
    assert_equal email.to, APP_CONFIG['admin_emails']

    email = @emails[1]
    assert_equal [report.student.email], email.to
    assert_match /Your report is taking longer to be graded than expected/, email.body

    email = @emails[2]
    assert_equal [grader.email], email.to
    assert_match /You have failed to grade the report within the allotted time/, email.body

    # todo: the question becomes: when do these object get reloaded?  the @ungraded_reports instance
    # variable does NOT get reloaded with an ActiveRecord 'reload', and so contains faulty data,
    # which is why grader.can_grade_another_report will not behave properly (return nil).  does
    # this require fixing or will it not too adversely affect the behavior of the app?
    grader.reload
    assert_equal nil, grader.can_grade_another_report

    grader = nil
    grader = users(:tardy_grader)
    assert (grader.can_grade_another_report)
    assert (grader.failed_to_grade report)
  end


  def test_notify_students_of_report_archiving
    report = reports(:report_ready_to_get_archived_notification)
    assert (not report.archive_notification_sent)

    CronRunner.notify_students_of_report_archiving

    report.reload
    assert_equal(1, @emails.size)
    email = @emails.first
    assert_equal [report.student.email], email.to
    assert_match /This is just a notification that your report on/, email.body
    assert report.archive_notification_sent

    CronRunner.notify_students_of_report_archiving
    assert_equal 1, @emails.size


  end

end
