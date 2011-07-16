require File.dirname(__FILE__) + '/../spec_helper'

describe HelpController, "when grader is using the system" do

  before(:each) do
    @emails = ActionMailer::Base.deliveries
    @emails.clear
    login_as :sean
    @grader = users(:sean)
  end

  def post_correct_help_request(options = {})
    post :submit, {:help_submission =>
        {:problem => 'I attached the wrong file for marked book report.',
            :report => @grader.graded_reports[0].id,
            :comment => 'Woops I messed up.  What do I do now?'
        }    }.merge(options)

  end

  it "should send out one email to admin after grader asks for help" do
    post_correct_help_request
    @emails.size.should == 1
  end

  it "should have correct email information when grader requests help" do
    post_correct_help_request
#    puts @emails[0]
    @emails[0].to.should == APP_CONFIG['admin_emails']
  end

  it "should correctly show report on grader email" do
    post_correct_help_request
    @emails[0].body.should =~ /Regarding/
    @emails[0].body.should =~ /Report/
  end

  it "should not show report on grader email if none was selected" do
    post_correct_help_request(:help_submission =>   {:problem => 'I attached the wrong file for marked book report.',
        :report =>  'none',
        :comment => 'Woops I messed up.  What do I do now?'
    } )
    #puts @emails[0]
    @emails[0].body.should_not =~ /Regarding/
    @emails[0].body.should_not =~ /Report/
  end

  it "should not show comment if none was entered" do
    post_correct_help_request(:help_submission =>   {:problem => 'I attached the wrong file for marked book report.',
        :report =>  'none',
        :comment => ''
    })
    @emails[0].body.should_not =~ /With comment/
  end

  it "should not show comment if none was entered" do
    post_correct_help_request(:help_submission =>   {:problem => 'I attached the wrong file for marked book report.',
        :report =>  'none',
        :comment => 'Something went wrong'
    })
    @emails[0].body.should =~ /With comment/
  end



end


describe HelpController, "when student is using the system" do

  before(:each) do
    @emails = ActionMailer::Base.deliveries
    @emails.clear
    login_as :bobby
    @student = users(:bobby)
  end

  def post_correct_help_request(options = {})
    post :submit, {:help_submission =>
        {:problem => 'I attached the wrong file for my book report.',
            :report => @student.ungraded_reports[0].id,
            :comment => 'Woops I messed up.  What do I do now?'
        }    }.merge(options)

  end

  it "should send out one email to admin after student asks for help" do
    post_correct_help_request
    @emails.size.should == 1
  end

  it "should have correct email information when student requests help" do
    post_correct_help_request
    #    puts @emails[0]
    @emails[0].to.should == APP_CONFIG['admin_emails']
  end

  it "should correctly show report on student email" do
    post_correct_help_request
    @emails[0].body.should =~ /Regarding/
    @emails[0].body.should =~ /Report/
  end

  it "should not show report on student email if none was selected" do
    post_correct_help_request(:help_submission =>   {:problem => 'I attached the wrong file for my book report.',
        :report =>  'none',
        :comment => 'Woops I messed up.  What do I do now?'
    } )
    @emails[0].body.should_not =~ /Regarding/
    @emails[0].body.should_not =~ /Report/
  end

  it "should show grader id on student email if report was graded" do
    post_correct_help_request(:help_submission =>   {:problem => 'I attached the wrong file for my book report.',
        :report =>  @student.graded_reports[0].id,
        :comment => 'Woops I messed up.  What do I do now?'
    } )
    @emails[0].body.should =~ /graded by grader/
  end

  it "should not show comment if none was entered" do
    post_correct_help_request(:help_submission =>   {:problem => 'I attached the wrong file for my book report.',
        :report =>  @student.graded_reports[0].id,
        :comment => ''
    })
    @emails[0].body.should_not =~ /With comment/
  end

  it "should not show comment if none was entered" do
    post_correct_help_request(:help_submission =>   {:problem => 'I attached the wrong file for my book report.',
        :report =>  @student.graded_reports[0].id,
        :comment => 'Something went wrong'
    })
    @emails[0].body.should =~ /With comment/
  end

end
