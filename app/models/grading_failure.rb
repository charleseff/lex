class GradingFailure < ActiveRecord::Base
  belongs_to :grader
  belongs_to :report

  def to_label
    report.to_label
  end

end
