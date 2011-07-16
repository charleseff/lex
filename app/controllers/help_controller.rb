class HelpController < AuthorizationController

  ssl_require_all
  layout 'main'

  def index
    render :action => user_index
  end

  def submit
    unless request.post?
      redirect_to root_path
      return
    end

    help_submission = params[:help_submission]

    if help_submission[:problem] == 'Please select a problem'
      flash[:message] = 'You did not select a problem frome list.  Please do so.'
      redirect_to :action => :index
      return
    end

    unless (help_submission[:report] == 'none' )
      @report = Report.find(help_submission[:report].to_i)
    end

    if current_user.is_a? Student
      Mailers::HelpMailer.deliver_student_help(@student, help_submission[:problem], @report, help_submission[:comment])
    else
      Mailers::HelpMailer.deliver_grader_help(@grader, help_submission[:problem], @report, help_submission[:comment])
    end
    flash[:message] = "Thank you! We have received your help request and will get back to you as soon as possible."
    redirect_to :action => :index

  end

  private
  def allowed_users
    Set.new  [Grader, Student]
  end

  def set_section
    @section = 'help'
  end

end
