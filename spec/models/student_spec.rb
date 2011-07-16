require File.dirname(__FILE__) + '/../spec_helper'

describe Student, "" do

  before(:each) do
    @student = users(:bobby)
  end

  it "should correctly calculate grade level with grade_level_from_value method" do
    @student.grade_level_form_value.should == @student.grade_level.level.to_s
  end

  it "should correctly calculate ungraded_reports as reports_not_assigned_to_a_grader and reports_assigned_to_a_grader_but_ungraded" do
    @student.ungraded_reports.to_set.should ==  (@student.reports_assigned_to_a_grader_but_ungraded + @student.reports_not_assigned_to_a_grader).to_set 
  end
  
  it "should correctly calculate most recently graded report" do
    @student.most_recently_graded_active_report.should == reports(:bobby_report_graded_most_recently)
  end

end