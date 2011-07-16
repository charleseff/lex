class StudentReportsController < AuthorizationController
  ssl_require_all
  include ShowsReports
  layout :get_layout

  before_filter :get_report, :only => [ :show, :message, :send_message, :download_graded_pdf, :download_submitted_doc, :download_graded_flash ]
  before_filter :check_report_graded_and_active, :only => [:message, :send_message]
  before_filter :check_report_graded, :only => [:download_graded_pdf, :download_graded_flash]

  def send_message
    dialog_message = DialogMessage.new(:message => params[:message])
    dialog_message.report = @report
    dialog_message.speaker = "Student"
    if dialog_message.save
      Mailers::MessageMailer.deliver_student_message(@report, dialog_message, Time.now)
      # redirect:
      @notice = 'Message was created for grader.'
    else
      @error = 'You must enter a message.'
    end
  end

  def show
    @page_title = "Report on #{@report.book.title}"
    if not @report.graded?
      render :action => :show_submitted, :layout => 'main'
    else
      render :partial => 'shared/reports/show_graded', :layout => 'main'
    end
  end

  def create
    if not request.post?
      redirect_to root_path
      return
    end

    book = Book.get_or_create_new_book(params[:book])
    if @student.reports.detect {|report| report.book == book}
      @errors = ['You have already submitted a book report with that title and author.  Please do not re-submit a book report that has already been submitted.
If there was an error with your report, please go to the Help section to notify us.']
      respond_to_ajax('create_error')
      return
    end

    @report = Report.new(params[:report].merge(:student => @student,  :book => book,
        :assignment_topic => AssignmentTopic.find_by_id( params[:assignment_topic][:id].to_i)    )
    )

    if @report.save
      respond_to_ajax
    else
      @errors = @report.errors.full_messages.find_all{|msg| not msg =~ /\ABook/ } + @report.book.errors.full_messages
      respond_to_ajax('create_error')
    end

  end

  private
  def set_section
    @section = 'reports'
  end

  def get_layout
    'main' if not request.path =~ /.*create\Z/
  end

  def allowed_users
    Set.new  [Student]
  end
end
