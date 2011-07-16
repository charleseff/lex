require File.dirname(__FILE__) + "/helper"


with_steps_for(:grader_reports) do
  run_local_story "grader_report_submission_story"
end