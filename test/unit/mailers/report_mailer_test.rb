require File.dirname(__FILE__) + '/../../test_helper'

class Mailers::ReportMailerTest < Test::Unit::TestCase
  FIXTURES_PATH = File.dirname(__FILE__) + '/../fixtures'
  CHARSET = "utf-8"

  include ActionMailer::Quoting

  fixtures :reports
  fixtures :books
  fixtures :users
  
  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @expected = TMail::Mail.new
    @expected.set_content_type "text", "plain", { "charset" => CHARSET }
    @expected.mime_version = '1.0'
  end
#
#  def test_graded
#    report = reports(:bobby_report_graded_by_sean)
#
#    @expected.subject = "Grader #{report.grader} has graded your report"
#    @expected.body    = read_fixture('graded')
#    @expected.date    = Time.now
#    @expected.to = report.student.email
#
#    assert_equal @expected.encoded, Mailers::ReportMailer.create_graded(report,@expected.date).encoded
#  end


  def test_truth
    assert true
  end

  private
    def read_fixture(action)
      IO.readlines("#{FIXTURES_PATH}/report_mailer/#{action}")
    end

    def encode(subject)
      quoted_printable(subject, CHARSET)
    end
end
