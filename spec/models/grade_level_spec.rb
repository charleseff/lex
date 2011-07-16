require File.dirname(__FILE__) + '/../spec_helper'

describe GradeLevel do

  before(:each) do
    @grade_level = GradeLevel.new
  end

  it "should be valid" do
    @grade_level.should be_valid
  end

  it "should have assignment topics" do
    grade_level = grade_levels(:grade_level_3)
    grade_level.assignment_topics.should == [assignment_topics(:two),assignment_topics(:three),assignment_topics(:four)]
  end

  it "should get correct assignment topic id" do
    grade_level = grade_levels(:grade_level_3)
    assignment_topic = assignment_topics(:two)
    assignment_topic_from_grade_level = grade_level.assignment_topics.detect {|topic| topic == assignment_topic}

    assignment_topic.id.should == assignment_topic_from_grade_level.id
  end
end
