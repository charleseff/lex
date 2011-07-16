class DialogMessage < ActiveRecord::Base
  belongs_to :report
  validates_presence_of :report_id, :message, :speaker

  def validate
    if (not (speaker == "Student") || (speaker == "Grader"))
      errors.add(:speaker, "must be either 'Student' or 'Grader'")
    end
  end

  # update report last activity time:
# we decided not to do this anymore:
=begin
  def before_create
    report.time_of_last_activity = Time.now
    report.save
  end
=end

end
