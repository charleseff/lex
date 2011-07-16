module ShowsReports

  def get_report
    if @report.nil? or ( not @report.id = params[:id])
      begin
        if [Student,Grader].include?(current_user.class )
          @report = current_user.reports.find(params[:id])
        else
          @report = Report.find(params[:id])
        end
      rescue
        redirect_to root_path
      end
    end
  end

  def check_report_graded_and_active
    redirect_to root_path if (not @report.graded? or not @report.active?)
  end

  def check_report_graded
    redirect_to root_path if not @report.graded?
  end

  def download_graded_pdf
    if ( (current_user.is_a? Student) and (@report.graded?) ) or
        ( (current_user.is_a? Grader) and (@report.has_pdf)) or
        (current_user.is_a? Administrator)
      send_data File.open(@report.path_to_graded_pdf,"r").read , :filename => @report.graded_pdf_filename, :type => "application/pdf"
    else
      redirect_to :action => :show, :id => @report
    end
  end

  def download_submitted_doc
    send_data File.open(@report.path_to_submitted_doc,"r").read , :filename => @report.submitted_doc_filename, :type => "application/msword"
  end

  def download_graded_flash
    send_data File.open(@report.path_to_graded_swf,"r").read , :filename => @report.graded_swf_filename, :type => "application/flash"
  end

end