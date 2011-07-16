require File.dirname(__FILE__) + '/../spec_helper'

describe Report, " when pre-existing" do

  it "should update updated_at column" do
    report = reports(:bobby_report_graded_by_sean)
    report.updated_at.should == report.created_at
    report.save!
    report.updated_at.should > report.created_at
  end

  it "should be graded if it has a graded_at column" do
    report = reports(:bobby_report_graded_by_sean)
    report.graded?.should be_true
  end

  it "should not be graded if it doesn't have a graded_at column" do
    report = reports(:bessy_report)
    report.graded?.should_not be_true
  end

  it "should retain old grade level even after user updates his/her grade level" do
    report = reports(:bessy_report)
    student = report.student
    original_grade_level = student.grade_level.level
    student.grade_level = GradeLevel.find_by_level(original_grade_level+ 1)
    student.save!

    report.grade_level.level.should_not == student.grade_level.level
    report.grade_level.level.should == original_grade_level
  end

end


describe Report, " when being created anew" do
  fixtures :reports, :books, :users

  def create_report
    @student = users(:bobby)
    @report = Report.new(:student =>@student, :book => books(:book_1), :assignment_topic => assignment_topics(:one),
        :submitted_doc => fixture_file_upload( '../fixtures/Grapes_of_Wrath_by_Bobby.doc', 'application/msword'))
    @report.save!
    @report.reload
  end

  it "should set grade level to the level of the student" do
    create_report
    @report.grade_level.should == @student.grade_level
  end

  it "should have updated updated_at and created_at values" do
    create_report
    (Time.now - @report.updated_at).should < 5.seconds
    (Time.now - @report.created_at).should < 5.seconds
  end

  it "should not have a last_saved_by_grader time" do
    create_report
    @report.last_saved_by_grader_at.should == nil
  end

  it "should fail to save report if grader assigned without assigned_to_grader_at date" do
    report = Report.new(:student => users(:bobby), :book => books(:book_1), :assignment_topic => assignment_topics(:one), :grader => users(:sean),
        :submitted_doc => fixture_file_upload( '../fixtures/Grapes_of_Wrath_by_Bobby.doc', 'application/msword'))
    report.should_not be_valid
  end

end