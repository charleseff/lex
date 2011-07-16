class GraderReportsController < AuthorizationController

  ssl_require_all
  include ShowsReports
  layout 'main'

  before_filter :get_report, :only => [ :grade, :show, :message, :send_message, :download_graded_pdf, :submit,
          :download_submitted_doc, :download_grader_doc, :show_preview,  :download_graded_flash ]
  before_filter :check_report_graded_and_active, :only => [:message, :send_message]

  def submit
    case params['submit_type']
    when 'save_and_finish_later'
      save_for_later
    when 'submit_and_preview'
      submit_and_preview
    else
      redirect_to root_path
    end

    trace_var
  end

  def grade
    if not @report.has_pdf or @report.graded?
      redirect_to root_path
      return
    end
    @report.graded_at = Time.now
    @report.save!
    Mailers::ReportMailer.deliver_graded(@report, Time.now)
    flash[:just_graded] = true
    redirect_to root_path
  end

  def download_grader_doc
    if (! @report.has_grader_doc?)
      redirect_to :action => :show, :id => @report
      return
    end
    send_data File.open(@report.path_to_grader_doc,"r").read , :filename => @report.grader_doc_filename, :type => "application/msword"
  end

  def show_preview
    redirect_to root_path unless @report.has_pdf
  end

  def show
    @page_title = "Report on #{@report.book.title}"
    if @report.submitted_for_preview and (not @report.graded?)
      @report.submitted_for_preview = false
      @report.save!
      @report.reload
    end

    if not @report.graded?
      render :action => :show_ungraded
    else
      render :partial => 'shared/reports/show_graded', :layout => 'main'
    end
  end

  def send_message
    dialog_message = DialogMessage.new(:message => params[:message])
    dialog_message.report = @report
    dialog_message.speaker = "Grader"
    if dialog_message.save
      Mailers::MessageMailer.deliver_grader_message(@report, dialog_message, Time.now)
      # redirect:
      @notice = 'Message was created for student.'
    else
      @error = 'You must enter a message.'
    end
  end

  private
  def allowed_users
    Set.new  [Grader]
  end

  def submit_and_preview
    @report.attributes = params[:report]
    add_graded_ptal_task_items
    @report.save_for_submission = true
    @report.submitted_for_preview = true

    if @report.valid_for_submission?
      @report.save!
      respond_to_ajax('submit_and_preview')
    else
      @report.graded_ptal_task_items += @temporarily_removed_task_items
      @errors =     @report.errors_for_submission
      respond_to_ajax('submit_and_preview_error')
    end
  end

  # for saving graded docs for later:
  def save_for_later
    add_graded_ptal_task_items
    @report.last_saved_by_grader_at = Time.now

    if @report.valid?
      @report.update_attributes!(params[:report])
      respond_to_ajax('save_for_later')
    else
      @report.graded_ptal_task_items += @temporarily_removed_task_items
      @errors = @report.errors.full_messages
      respond_to_ajax('save_for_later_error')
    end
  end

  def add_graded_ptal_task_items
    @temporarily_removed_task_items = []
    @report.grade_level.ptal_task_items.each do |ptal_task_item|
      attributes = params["graded_ptal_task_item_#{ptal_task_item.id}"]
      existing_task_item = @report.graded_ptal_task_items.detect{|item| ptal_task_item.id == item.ptal_task_item_id}
      if not attributes or not attributes[:points_earned] or attributes[:points_earned] == ''
        if  existing_task_item
          @report.graded_ptal_task_items.delete( existing_task_item)
          # argh.. it has to actually remove the item from the report, so we have to add it back in case of error..
          @temporarily_removed_task_items  << existing_task_item
        end
      else
        if existing_task_item
          existing_task_item.update_attributes(attributes)
        else
          attributes[:ptal_task_item] = ptal_task_item
          attributes[:report] = @report
          @report.graded_ptal_task_items.build attributes
        end

      end
    end
  end

  def set_section
    @section = 'reports'
  end

end