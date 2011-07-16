require File.dirname(__FILE__) + '/../test_helper'
require 'report_queue_controller'

# Re-raise errors caught by the controller.
class ReportQueueController; def rescue_action(e) raise e end; end

class ReportQueueControllerTest < Test::Unit::TestCase
  fixtures :reports
  fixtures :users

  def setup
    super
    @controller = ReportQueueController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @emails     = ActionMailer::Base.deliveries
    @emails.clear
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end

  # commented out now that we're disabling 'grade_new' completely
=begin

  def test_grader_cant_be_assigned_to_report_already_assigned_to_another_grader
    login_as :sean

    post :grade_new, :id => reports(:bobby_report_graded_by_sean).id
    assert_response :success
    assert_tag :content => /.*That report already has a grader assigned to it\..*/
  end

=end


  def test_grader_that_has_active_report_cant_take_on_another_report
    login_as :sean
    post :auto_assign
    assert_redirected_to :controller => :home, :action=>:index
  end

  def test_grader_can_have_report_assigned
    login_as :donna
    post :auto_assign
    assert_redirected_to :controller => :grader_reports
  end

  # used to send an email to student, but not anymore
  def test_ensure_mail_wasnt_sent_when_grader_takes_on_report
    login_as :donna
    post :auto_assign
    assert_equal(0, @emails.size)

=begin

    email = @emails.first
    assert_match(/A grader has picked up your report on/ , email.subject)
    assert_match(/Once the grader has completed grading your report, you will get another email notification/, email.body)

=end

  end

  def test_ensure_picking_up_report_updates_assigned_to_grader_at_date_of_report
    login_as :donna
    post :auto_assign
    report = users(:donna).reports[0]

    assert Time.now - report.assigned_to_grader_at < 5.seconds
  end

end
