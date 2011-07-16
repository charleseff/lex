require File.dirname(__FILE__) + "/helper"
# just gonna skip for now, don't seem to be taking fixtures...
=begin

require File.dirname(__FILE__) + "/helper"


steps_for(:grader_settings) do

    Given("a logged in grader with grades 1, 3, and 7 as preferred grade levels") do
      @grader = users(:sean)
    end

    When("the grader removes grade 3 and 1 as a preferred grade level") do

    end

    Then("there should be only grade level 7 checked off as preferred grade level") do

    end

end

with_steps_for(:grader_settings) do
  run_local_story "grader_settings_story"
end
=end


=begin


with_steps_for(:grader_settings) do
 # run_local_story "grader_report_submission_story"
end
=end

