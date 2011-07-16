class ReportQueueController < AuthorizationController
  ssl_require_all

  def auto_assign
    if (not request.post? or (not @grader.can_grade_another_report))
      redirect_to root_path
      return
    end

    # section off test lex grader/student, and example grader/student from rest of field:
    if @grader.email == 'test_lex_grader@barrelny.com'
      report_to_assign = Report.find(:first, :conditions => { :student_id => Student.find_by_email('test_lex_student@barrelny.com'), :grader_id => nil })
    elsif  @grader.email == 'grader@example.com'
      report_to_assign = Report.find(:first, :conditions => { :student_id => Student.find_by_email('student@example.com'), :grader_id => nil })
    else
      unassigned_reports = Report.unassigned_reports
      if (unassigned_reports.empty?)
        flash[:status] = 'Sorry, there are no reports available to be graded at this time.  Please check back later.'
        redirect_to root_path
        return
      end

      report_to_assign = nil
      first_selected = false
      first_report = nil
      # should be ordered by creation_date, least recent first:
      unassigned_reports.each do |unassigned_report|
        if (@grader.failed_to_grade unassigned_report)
          next
        elsif Time.now - unassigned_report.created_at > 24.hours
          report_to_assign = unassigned_report
          break
        elsif @grader.prefers_grade_level(unassigned_report.grade_level.level)
          report_to_assign = unassigned_report
          break
        end
        if not first_selected
          first_report = unassigned_report
          first_selected = true
        end
      end
      report_to_assign = first_report if report_to_assign == nil
    end

    if report_to_assign == nil
      flash[:status] = 'Sorry, there are no reports available to be graded at this time.  Please check back later.'
      redirect_to root_path
      return
    end

    assign_report(report_to_assign)
  end

  # completely disable this for now:
=begin

  def grade_new
    report = Report.find(params[:id])
    if (report.has_@grader?)
      flash[:error] = 'That report already has a grader assigned to it.'
      render :action => :index
      return
    elsif (not current_user.can_grade_another_report)
      redirect_to root_path
      return
    end

    report.grader = current_user
    if report.save
      flash[:notice] = 'You have now just taken on a new report for grading.'
      Mailers::ReportMailer.deliver_assigned(report, Time.now)
      redirect_to(:controller => 'grader_reports')
    else
      flash[:error] = 'Error assigning new report'
      render :action => :index

    end
  end

=end

  private
  def allowed_users
    Set.new  [Grader]
  end

  def assign_report(report)

    report.grader = current_user
    # update last activity date for report:
    report.assigned_to_grader_at = Time.now

    report.save!
    # removed for now, student doesnt recieve notification when grader is assigned to report
    #    Mailers::ReportMailer.deliver_assigned(report, Time.now)
    redirect_to(:controller => :grader_reports, :action => :show, :id => report)
  end

end