require "#{File.dirname(__FILE__)}/../test_helper"
require "#{File.dirname(__FILE__)}/common_integration_test"
#require 'test/unit'
require 'rubygems'
require 'mocha'

# this sucks, for some reason using spec on ajax-ed requests isn't working ..... ARGHHH
class GradingReportsTest < ActionController::IntegrationTest
  include CommonIntegrationTest

  fixtures :users, :assignment_topics

  def setup
    super
    @emails     = ActionMailer::Base.deliveries
    @emails.clear
    @grader = users(:donna)

    # using mocha for stubbing:
    JodConverter.stubs(:convert).returns nil
    PdfToSwfConverter.stubs(:convert).returns nil
  end

  def submit_and_preview(args={})
    report =  reports(:bobby_report_assigned_to_but_ungraded_by_sean)
    multipart_post  'grader_reports/submit',   {'submit_type' => 'submit_and_preview',
        :id => report.id,
        :report => {:grader_comment => 'comment',
            :grader_doc => fixture_file_upload( '../fixtures/AgeOfTurbulenceGraded.doc', 'application/msword')}
    }.merge!(create_mock_ptal_data(report)).merge!(args)

  end

  def get_link_embedded_in_ajax_response_of(body)
    body.scan(/'(.*)'/)
    get $1
  end

  def test_report_doesnt_show_a_last_saved_date_when_first_being_assigned
    login_as @grader
    post 'report_queue/auto_assign'
    assert_no_match  /You last saved this report/, @response.body
  end

  def test_report_shows_a_last_saved_date_when_being_saved
    login_as @grader
    post 'report_queue/auto_assign'
    report = response.redirected_to[:id]
    request_hash =  { :id => report.id,
        :report => {:grader_comment => 'comment',
            :grader_doc => fixture_file_upload( '../fixtures/AgeOfTurbulenceGraded.doc', 'application/msword')},
        'submit_type' => 'save_and_finish_later'}
    request_hash.merge! create_incomplete_mock_ptal_data(report)
    multipart_post 'grader_reports/submit', request_hash

    # now re-get the page:
    get 'grader_reports/show', :id => report.id
    assert_match  /You last saved this report/, @response.body
  end

  def test_previewing_a_report_works
    login_as users(:sean)
    submit_and_preview
    get_link_embedded_in_ajax_response_of(@response.body)
    assert_match /To confirm and send to student, scroll down and click on/, @response.body
  end

end
