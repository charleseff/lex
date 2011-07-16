require File.dirname(__FILE__) + '/../../test_helper'

class Mailers::AccountMailerTest < Test::Unit::TestCase
  FIXTURES_PATH = File.dirname(__FILE__) + '/../fixtures'
  CHARSET = "utf-8"

  include ActionMailer::Quoting

  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @expected = TMail::Mail.new
    @expected.set_content_type "text", "plain", { "charset" => CHARSET }
    @expected.mime_version = '1.0'
  end
  
  def test_truth
    assert true
  end


=begin

  def test_new_user
    report = Report.find(2)
    message = DialogMessage.find(2)


    @expected.subject = 'Mailers::AccountMailer#new_grader'
    @expected.body    = read_fixture('new_grader')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Mailers::AccountMailer.create_new_grader(@expected.date).encoded
  end

=end



=begin

  def test_reset_password
    @expected.subject = 'Mailers::AccountMailer#reset_password'
    @expected.body    = read_fixture('reset_password')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Mailers::AccountMailer.create_reset_password(@expected.date).encoded
  end

=end


  private
    def read_fixture(action)
      IO.readlines("#{FIXTURES_PATH}/account_mailer/#{action}")
    end

    def encode(subject)
      quoted_printable(subject, CHARSET)
    end
end
