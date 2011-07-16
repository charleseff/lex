class Mailers::ReportMailer < Mailers::EmailNotifier

  def graded(report, sent = Time.now)
    setup_email
    @subject    = create_subject "Your report on #{report.book.title} has been graded"
    @body       = {:report => report}
    @recipients = report.student.email
    @sent_on    = sent
  end

  def assigned(report, sent = Time.now)
    setup_email
    @subject    = create_subject "A grader has picked up your report on #{report.book.title}"
    @body       = {:report => report}
    @recipients = report.student.email
    @sent_on    = sent
  end

  def ungraded_warning(report, sent = Time.now)
    setup_email
    @subject    = create_subject "You must grade and submit your report by #{report.grader.tz.utc_to_local(report.grading_due).strftime('%B %d, %Y %l:%M%p')}"
    @body       = {:report => report}
    @recipients = report.grader.email
    @sent_on    = sent
  end

  def student_dropped_grader(report, sent = Time.now)
    setup_email
    @subject    = create_subject "Your report is taking longer to be graded than expected."
    @body       = {:report => report}
    @recipients = report.student.email
    @sent_on    = sent
  end


  def grader_dropped_grader(report, grader, sent = Time.now)
    setup_email
    @subject    = create_subject "You failed to grade the report in the allotted time."
    @body       = {:report => report}
    @recipients = grader.email
    @sent_on    = sent
  end

  def archive_notification(report, grader, sent = Time.now)
    setup_email
    @subject    = create_subject "You have #{HOURS_BEFORE_SENDING_REPORT_ARCHIVE_NOTICE} more hours before your report becomes archived."
    @body       = {:report => report}
    @recipients = report.student.email
    @sent_on    = sent
  end

end
