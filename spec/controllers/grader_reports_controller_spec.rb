require File.dirname(__FILE__) + '/../spec_helper'

describe GraderReportsController do

  before(:each) do
    @emails = ActionMailer::Base.deliveries
    @emails.clear

    JodConverter.stub!(:convert).and_return {
      filename = "#{APP_CONFIG['temp_file_directory']}/test_file.pdf"
      # todo: hmm there must be some way to do this in ruby:
      `touch #{filename}`
      filename
    }
    PdfToSwfConverter.stub!(:convert).and_return {
      filename = "#{APP_CONFIG['temp_file_directory']}/test_file.swf"
      `touch #{filename}`
      filename
    }
    login_as :sean
    @report = reports(:bobby_report_assigned_to_but_ungraded_by_sean)
  end

  def do_submit_and_preview
    request_hash =  { :id => @report.id,
        :report =>
            {:grader_doc => fixture_file_upload( '../fixtures/AgeOfTurbulenceGraded.doc', 'application/msword'),
                :grader_comment => 'comment'
            },
        'submit_type' => 'submit_and_preview'}.merge! create_mock_ptal_data(@report)
    post :submit, request_hash
  end

  def do_submit_and_preview_with_request_hash(request_hash)
    post :submit, request_hash.merge( :submit_type => 'submit_and_preview')
  end


  def do_save_for_later(request_hash={})
    post :submit, {:id => @report.id, :report =>
        {:grader_doc => fixture_file_upload( '../fixtures/AgeOfTurbulenceGraded.doc', 'application/msword')},
        'submit_type' => 'save_and_finish_later'}.merge(request_hash)
  end

  def post_grade
    post :grade, :id => @report.id
  end

  it "should run a conversion when submitting for preview" do
    JodConverter.should_receive(:convert)
    do_submit_and_preview
  end

  it "should show success when successfully saving a doc for later" do
    do_save_for_later
    #puts response.body
    # todo : another one where the partial isn't rendering correctly....
    response.body.should =~ /save_for_later/
  end

  it "should successfully submit a report from a previously saved doc" do
    do_save_for_later
    post :submit, { :id => @report.id, :grader_doc =>
        {:uploaded_data => fixture_file_upload( '../fixtures/AgeOfTurbulenceGraded.doc', 'application/msword')},
        :report => {:grader_comment => 'comment'} }.merge(create_mock_ptal_data(@report))
    post_grade
    response.should redirect_to( root_path)
  end

  it "should redirect to show preview page after submitting to preview" do
    do_submit_and_preview
    #puts response.body
    # todo: *THIS IS WRONG, FIX THIS** for now, just testing to see that the correct partial is (supposed) to be rendered
    # i think i know why, Rspec is mocking out the views..arghh... gotta use stories forrealz
    response.body.should =~ /submit_and_preview/

    #   response.should redirect_to(:controller => 'grader_reports', :action => 'show_preview', :id => @report)
  end

  it "should send an email when grader grades report" do
    do_submit_and_preview
    post_grade
    @emails.size.should == 1
    email = @emails.first
    email.subject.should == "Your report on #{@report.book.title} has been graded"
    email.to[0].should ==   @report.student.email
  end

  it "should redirect to page when grading a report" do
    do_submit_and_preview
    post_grade
    response.should redirect_to( root_path)
  end

  it "should save last_saved_by_grader_at time when saving a report" do
    last_time_saved = @report.last_saved_by_grader_at
    do_save_for_later
    @report.reload
    @report.last_saved_by_grader_at.should > last_time_saved
  end


  it "should update activity date when grading report" do
    (Time.now - @report.assigned_to_grader_at ).should > 5.seconds
    do_submit_and_preview
    post_grade
    @report.reload
    (Time.now - @report.graded_at ).should < 5.seconds
  end

  it "should not save graded report file if it attempting to submit and preview with an attached graded report and there was an error" do
    do_submit_and_preview_with_request_hash(  { :id => @report.id, :grader_doc =>
        {:uploaded_data => fixture_file_upload( '../fixtures/AgeOfTurbulenceGraded.doc', 'application/msword')}
    })
    #puts response.body
    @report.grader_doc.should == nil
  end

  it "should properly replace grader doc" do
    do_save_for_later
    @report.reload
    first_size = File.size(@report.path_to_grader_doc)

    do_save_for_later( :report =>{:grader_doc => fixture_file_upload( '../fixtures/AgeOfTurbulenceGraded2.doc', 'application/msword')})
    @report.reload
    File.size(@report.path_to_grader_doc).should_not == first_size
  end
end
