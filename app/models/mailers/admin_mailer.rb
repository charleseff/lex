class Mailers::AdminMailer < Mailers::EmailNotifier

  def warnings_sent_report(reports, sent = Time.now)
    setup_email
    @subject    = create_subject "Graders have received warning regarding ungraded reports"
    @body       = {:reports => reports}
    @recipients = APP_CONFIG['admin_emails']
    @sent_on    = sent
  end

  def graders_dropped_report(reports, sent = Time.now)
    setup_email
    @subject    = create_subject "Graders have been dropped from grading reports"
    @body       = {:reports => reports}
    @recipients = APP_CONFIG['admin_emails']
    @sent_on    = sent
  end


end
