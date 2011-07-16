require File.dirname(__FILE__) + '/../spec_helper'

describe Resource do
  before(:each) do
    @resources = Resource.new
  end

  it "should be valid" do
    @resources.should be_valid
  end
end
