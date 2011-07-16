require File.dirname(__FILE__) + '/../test_helper'
require 'student_reports_controller'

# Re-raise errors caught by the controller.
class StudentReportsController; def rescue_action(e) raise e end; end

# based on: http://www.fngtps.com/2007/04/testing-with-attachment_fu
# this method is overwritten to upload files to temp directory instad of public (not cool)
# why does this cause problems with Report.new ?
#class Report
#  def full_filename(thumbnail = nil)
#    file_system_path = (thumbnail ? thumbnail_class : self).attachment_options[:path_prefix].to_s
#    File.join(Dir::tmpdir(), file_system_path, *partitioned_path(thumbnail_name_for(thumbnail)))
#  end
#end

class StudentReportsControllerTest < Test::Unit::TestCase

  fixtures :users, :reports, :grade_levels, :graded_ptal_task_items

  def setup
    super
    @controller = StudentReportsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end


  def test_report_page_shows_some_correct_content
    report = reports(:bobby_report_graded_by_sean)
    login_as :bobby
    get :show, :id => report
    assert_tag :content => /.*#{report.book.title}.*/
    assert_response :success
  end

  def test_report_not_yet_assigned_to_grader
    login_as :bobby

    get :show, :id => reports(:bobby_report_no_grader)
    assert_response :success
    assert_tag :content => /.*You will receive an e-mail once your book report has been graded..*/
  end

  def test_report_assigned_to_but_not_graded_by_grader
    login_as :bobby

    get :show, :id => reports(:bobby_report_assigned_to_but_ungraded_by_sean)
    assert_tag :content => /.* This book report is currently being graded\.  You will receive an e-mail once it is ready\..*/

  end

  def test_report_has_been_graded
    login_as :bobby
    report = reports(:bobby_report_graded_by_sean)

    get :show, :id => report
    assert_response :success
    assert_tag :content => /.*This report was graded on.*/

  end

  def test_ensure_student_cant_access_report_he_doesnt_have
    login_as :student_with_no_reports
    get :show, :id => reports(:bobby_report_graded_by_sean)
    assert_response :redirect

  end

  def test_ensure_student_can_access_report_he_has
    login_as :bobby
    get :show, :id => reports(:bobby_report_graded_by_sean)
    assert_response :success

  end

  def test_cant_send_message_if_report_isnt_graded
    # assert that report isn't graded:
    report = reports(:ready_to_be_dropped_report)
    assert (not report.graded?)

    login_as :bobby
    get :message, :id => report
    assert_response :redirect
  end

  def test_show_report_pages_load
    login_as :bobby

    # graded:
    get :show, :id => reports(:bobby_report_graded_by_sean)
    assert_response :success

    # submitted:
    get :show, :id => reports(:bobby_report_no_grader)
    assert_response :success

    # archived:
    get :show, :id => reports(:bobby_report_graded_and_inactive)
    assert_response :success
  end

end
