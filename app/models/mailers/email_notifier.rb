class Mailers::EmailNotifier < ActionMailer::Base

  def activation(user)
    setup_email
    @body[:url]  = "#{user.activation_url}"
  end

  protected
  def setup_email
    @from         = "Lex Kim Book Reports <#{ENV['RAILS_ENV'] == 'staging' ? 'mailer@cmanfu.com' : 'no_reply@lexkimbookreports.com' }>"
    @headers      =   {  "Mime-Version" => "1.0"
    }
  end

  def create_subject(subject)
    subject = (ENV['RAILS_ENV'] == 'staging' ? '[STAGING] ' : '') + subject
    return subject
  end
end

