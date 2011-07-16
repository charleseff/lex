class Mailers::HelpMailer < Mailers::EmailNotifier

  def grader_help(grader, problem, report, comment, sent = Time.now)
    setup_email
    @subject    = create_subject( "Grader #{grader.first_name} #{grader.last_name} has submitted a help request")
    @body       = {:grader => grader, :problem => problem, :report => report, :comment => comment}
    @recipients = APP_CONFIG['admin_emails']
    @sent_on    = sent
  end

  def student_help(student, problem, report, comment, sent = Time.now)
    setup_email
    @subject    = create_subject( "Student #{student.first_name} #{student.last_name} has submitted a help request")
    @body       = {:student => student, :problem => problem, :report => report, :comment => comment}
    @recipients = APP_CONFIG['admin_emails']
    @sent_on    = sent
  end

end
