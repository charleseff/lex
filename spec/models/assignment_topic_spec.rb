require File.dirname(__FILE__) + '/../spec_helper'

describe AssignmentTopic do
  before(:each) do
    @assignment_topic = AssignmentTopic.new
  end

  it "should be valid" do
    @assignment_topic.should be_valid
  end
end
