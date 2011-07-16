class Mailers::MessageMailer < Mailers::EmailNotifier

  def student_message(report, message, sent)
    setup_email
    @subject    = create_subject( "Student #{report.student} has sent you " <<
            ((report.student_messages.size > 1) ? "another" : "a") <<
            " message regarding his/her report on #{report.book}")
#             has sent you a message regarding the report'
    @body       = {:report => report, :message => message}
    @recipients = report.grader.email
    @sent_on    = sent
  end

  def grader_message(report, message, sent)
    setup_email
    @subject    = create_subject ("Grader #{report.grader} has sent you " <<
            ((report.grader_messages.size > 1) ? "another" : "a") <<
            " message regarding your report on #{report.book}")
    @body       = {:report => report, :message => message}
    @recipients = report.student.email
    @sent_on    =  sent
  end
end
