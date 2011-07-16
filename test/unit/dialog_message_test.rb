require File.dirname(__FILE__) + '/../test_helper'

class DialogMessageTest < Test::Unit::TestCase
  fixtures :dialog_messages, :reports

=begin

  def test_not_updated_report_last_activity_time
    report = reports(:bobby_report_graded_by_sean)
    assert 1.days.ago - report.assigned_to_grader_at < 5.minutes
    dialog_message = DialogMessage.new(:report => report, :message => 'test', :speaker => 'Student')
    dialog_message.save!
    assert (not Time.now - report.assigned_to_grader_at  < 5.minutes)
  end
=end
  
  def test_truth
    assert true
  end

  
end
