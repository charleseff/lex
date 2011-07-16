require 'rubygems'
require 'spec/story'

steps_for(:grader_reports) do

  Given("a logged in grader with ungraded report") do
    @grader = users(:sean)
#    pending "not done"
 #   fixtures :users
  #  debugger
    f = 3
  end

  When("the grader submits a report for previewing") do
    pending "not done"
#    @recipe.save
  end

  Then("he should be redirected to the preview page") do
    pending "not done"
#    @recipe.should be_valid
  end

end