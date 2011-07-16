class Mailers::AccountMailer < Mailers::EmailNotifier

  def new_user(user, confirmation_code, sent_at = Time.now)
    setup_email    
    @subject    = create_subject 'Welcome to Lex Kim Book Reports!'
    @body       = {:user => user, :code => confirmation_code.code }
    @recipients = user.email
    @sent_on    = sent_at
  end

  def reset_password_request(user, confirmation_code, sent_at = Time.now)
    setup_email
    @subject    = create_subject 'Reset Password Request for Lex Kim Book Reports'
    @body       = {:user => user, :code => confirmation_code.code }
    @recipients = user.email
    @sent_on    = sent_at
  end

  def change_email_request(user, email_change_request, sent_at = Time.now)
    setup_email
    @subject    = create_subject 'Change Email Request for Lex Kim Book Reports'
    @body       = {:user => user, :email_change_request => email_change_request }
    @recipients = email_change_request.email
    @sent_on    = sent_at
  end
end
