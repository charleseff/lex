require File.dirname(__FILE__) + '/../test_helper'
require "#{File.dirname(__FILE__)}/common_integration_test"

class GraderIntegrationTest < ActionController::IntegrationTest
  include CommonIntegrationTest
  fixtures :users, :reports, :books, :grade_levels, :ptal_task_items

  # see http://dev.rubyonrails.org/ticket/4635 for solution to get file uploads working through integration tests:
  def test_assert_grade_report_fails_if_ptal_isnt_filled_out
    login_as users(:sean)
    report = reports(:bobby_report_assigned_to_but_ungraded_by_sean)
    id = report.id
    multipart_post 'grader_reports/submit', :id => id, :grader_doc =>
        {:uploaded_data => fixture_file_upload( '../fixtures/AgeOfTurbulenceGraded.doc', 'application/msword')},
        :report => {:grader_comment => 'comment'},
        'submit_type' => 'submit_and_preview'
    assert_match /You must choose a value for every task item in the PTAL/, @response.body
  end

  def test_ensure_grader_must_make_final_comment
    login_as users(:sean)
    report = reports(:bobby_report_assigned_to_but_ungraded_by_sean)
    id = report.id
    request_hash = { :id => id, :grader_doc =>
        {:uploaded_data => fixture_file_upload( '../fixtures/AgeOfTurbulenceGraded.doc', 'application/msword')},
        'submit_type' => 'submit_and_preview' }
    request_hash.merge! create_mock_ptal_data(report)
    multipart_post  'grader_reports/submit', request_hash
    assert_match /You must make a final comment/, @response.body
  end


# with ajax, this will automatically happen
=begin

  def test_unsuccessfully_submitting_a_report_still_retains_ptal_values
    login_as users(:sean)

    report = reports(:bobby_report_assigned_to_but_ungraded_by_sean)
    id = report.id
    get '/grader_reports/show', :id => id
    assert_no_match /<option value="1" selected="selected">1/, @response.body

    request_hash = { :id => id, :grader_doc =>
        {:uploaded_data => fixture_file_upload( '../fixtures/AgeOfTurbulenceGraded.doc', 'application/msword')},
        'submit_type' => 'submit_and_preview' }
    request_hash.merge! create_mock_ptal_data(report)
    multipart_post  'grader_reports/submit', request_hash
    assert_match /You must make a final comment/, @response.body
    assert_match /<option value="1" selected="selected">1/, @response.body
  end

=end


  def test_when_grader_unsuccessfully_grades_report_ptal_data_doesnt_get_erased
    login_as users(:sean)
    report = reports(:bobby_report_assigned_to_but_ungraded_by_sean)
    assert report.graded_ptal_task_items.empty?
    id = report.id
    request_hash =  { :id => id, :grader_doc =>
        {:uploaded_data => fixture_file_upload( '../fixtures/AgeOfTurbulenceGraded.doc', 'application/msword')},
        :report => {:grader_comment => 'comment'},
         'submit_type' => 'save_and_finish_later'}
    request_hash.merge! create_incomplete_mock_ptal_data(report)
    multipart_post 'grader_reports/submit', request_hash
    report.reload
    assert_equal 14, report.graded_ptal_task_items.size

    request_hash_2 =  { :id => id, 'submit_type' => 'submit_and_preview'}
    multipart_post 'grader_reports/submit', request_hash_2
    assert_match /You must choose a value for every task item in the PTAL/, @response.body

    report.reload
    assert_equal 14, report.graded_ptal_task_items.size
  end

end