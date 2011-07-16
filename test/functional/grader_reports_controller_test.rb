require File.dirname(__FILE__) + '/../test_helper'
require 'grader_reports_controller'

# Re-raise errors caught by the controller.
class GraderReportsController; def rescue_action(e) raise e end; end

class GraderReportsControllerTest < Test::Unit::TestCase
  fixtures :users, :reports, :books, :grade_levels, :ptal_task_items, :graded_ptal_task_items

  def setup
    super
    @controller = GraderReportsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @emails     = ActionMailer::Base.deliveries
    @emails.clear
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end

  def test_ensure_grader_cant_access_report_he_isnt_grading
    login_as :sean
    get :show, :id => reports(:bobby_report_no_grader)
    assert_response :redirect
  end

  def test_ensure_grader_can_access_report_he_is_grading
    login_as :sean
    get :show, :id => reports(:bobby_report_graded_by_sean)
    assert_response :success
  end

  def test_ensure_student_doesnt_have_access_to_grader_pages
    login_as :bobby
    get :index
    assert_response :redirect
  end

  def test_getting_download_graded_redirects_to_show_report_if_ungraded
    login_as :sean
    id = reports(:bobby_report_assigned_to_but_ungraded_by_sean).id
    get :download_graded_pdf, :id => id
    assert_redirected_to :action => :show, :id => id
  end

  def test_can_save_a_graded_report_for_later_without_submitting_a_graded_doc
    login_as :sean
    report = reports(:bobby_report_assigned_to_but_ungraded_by_sean)
    id = report.id
    post :submit, :id => id,
        :report => {:grader_doc => '' },
        'submit_type' => 'save_and_finish_later'
    assert_match( /You have saved this unfinished graded report/,@response.body)
  end


=begin

  it "should redirect to show preview page after submitting to preview" do
    do_preview_and_submit
    puts response.body
    response.should redirect_to(:controller => 'grader_reports', :action => 'show_preview', :id => @report)
  end

=end

  def test_should_redirect_to_show_preview_page_after_submitting_to_preview
# todo
  end

  protected
  def create_mock_ptal_data (report)
    hash = {}
    report.grade_level.ptal_task_items.each do |ptal_task_item|
      hash["graded_ptal_task_item_#{ptal_task_item.id}"] = {}
      hash["graded_ptal_task_item_#{ptal_task_item.id}"][:points_earned] = "1"
    end
    hash
  end



end
