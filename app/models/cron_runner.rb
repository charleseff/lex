class CronRunner

  # checks the graded status of reports picked up by graders.  if any of them have a time elapsed
  # of > MAX_TIME_TO_GRADE_REPORTS, then drop that report from the grader and send an email, and make that report
  # top priority.  if MAX_TIME_TO_GRADE_REPORTS - 24 < time_assigned < MAX_TIME_TO_GRADE_REPORTS, send an email warning
  # the grader that he has 24 hours more to grade the report.
  def self.run_all
    warn_graders
    drop_graders

    # commented out: reports don't get archived anymore
#    notify_students_of_report_archiving
  end

  private

  def self.notify_students_of_report_archiving
    reports_where_student_needs_archive_notification =  Report.find(:all, :conditions =>
            "not graded_at is null AND
              now() > date_add(graded_at, interval #{MAX_IDLE_ACTIVE_TIME - HOURS_BEFORE_SENDING_REPORT_ARCHIVE_NOTICE.hours} second) AND
              now() < date_add(graded_at, interval #{MAX_IDLE_ACTIVE_TIME} second) AND
              archive_notification_sent = false" )

    if reports_where_student_needs_archive_notification.empty?
      RAILS_DEFAULT_LOGGER.info("CRON_RUNNER :: No students needed a report archiving notice this time.")
    else
      RAILS_DEFAULT_LOGGER.info("CRON_RUNNER :: #{reports_where_student_needs_archive_notification.size} students are to receive notice of report being archived.")
      reports_where_student_needs_archive_notification.each do |report|
        report.archive_notification_sent = true
        report.save!
        Mailers::ReportMailer.deliver_archive_notification(report, Time.now)
        RAILS_DEFAULT_LOGGER.info("CRON_RUNNER :: #{report.student.to_label} was notified about the impending archiving of #{report}.")
      end
    end

  end

  def self.warn_graders
    reports_where_grader_needs_warning =  Report.find(:all, :conditions =>
            "graded_at is null AND
grader_id is not null AND
now() < date_add(assigned_to_grader_at, interval #{MAX_TIME_TO_GRADE_REPORTS} second) AND
now() > date_add( assigned_to_grader_at , interval #{MAX_TIME_TO_GRADE_REPORTS} - #{HOURS_BEFORE_SENDING_REPORT_DUE_WARNING.hours} second) AND
grader_was_warned = false" )

    if reports_where_grader_needs_warning.empty?
      RAILS_DEFAULT_LOGGER.info("CRON_RUNNER :: No graders needed to be warned this time.")
    else
      RAILS_DEFAULT_LOGGER.info("CRON_RUNNER :: #{reports_where_grader_needs_warning.size} graders are to be warned.")
      reports_where_grader_needs_warning.each do |report|
        report.grader_was_warned = true
        report.save!
        Mailers::ReportMailer.deliver_ungraded_warning(report, Time.now)
        RAILS_DEFAULT_LOGGER.info("CRON_RUNNER :: #{report.grader.to_label} was warned about #{report}.")
      end
      Mailers::AdminMailer.deliver_warnings_sent_report(reports_where_grader_needs_warning, Time.now)

    end
  end

  def self.drop_graders
    reports_failed_to_be_graded =  Report.find(:all, :conditions =>
            "graded_at is null AND
grader_id is not null AND
 now() > date_add( assigned_to_grader_at, interval #{MAX_TIME_TO_GRADE_REPORTS} second)  " )
    reports_failed_to_be_graded = reports_failed_to_be_graded.select{ |report| report.grading_due < DateTime.now }

    if reports_failed_to_be_graded.empty?
      RAILS_DEFAULT_LOGGER.info("CRON_RUNNER :: No graders needed to be dropped from their currently assigned report.")
    else
      RAILS_DEFAULT_LOGGER.info("CRON_RUNNER :: #{reports_failed_to_be_graded.size} graders need to be dropped from their currently assigned report.")

      # deliver these reports before actually changing the database so that the grader is still tied to the report
      # (not necessary but makes things cleaner.  may not be the best move..)
      Mailers::AdminMailer.deliver_graders_dropped_report(reports_failed_to_be_graded, Time.now)

      reports_failed_to_be_graded.each do |report|
        grader = report.grader

        # create new failure
        grading_failure = GradingFailure.new(:report => report, :grader => report.grader)
        grading_failure.save!

        # remove all grader stuff:
        report.grader_was_warned = false
        report.graded_ptal_task_items.each do |item|
          GradedPtalTaskItem.delete(item)
        end
#      report.graded_ptal_task_items = nil
        report.grader_comment = nil
        report.grader_doc_updated_at = nil
        report.has_pdf = false
        report.grader = nil
        report.assigned_to_grader_at = nil
        report.last_saved_by_grader_at = nil
        
        report.save!

        # send an email to grader and student:
        Mailers::ReportMailer.deliver_student_dropped_grader(report, Time.now)
        Mailers::ReportMailer.deliver_grader_dropped_grader(report, grader, Time.now)

        RAILS_DEFAULT_LOGGER.info("CRON_RUNNER :: #{grader.to_label} was dropped from grading report #{report}.")
      end

    end

  end



end

