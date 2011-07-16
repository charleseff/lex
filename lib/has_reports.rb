# gives some functionality to students and graders, both of whom have reports
# todo: i really want to simplify this module (way too much code duplication, not comfortable enough in ruby yet tho)
module HasReports

  def active_reports
    @active_reports ||= reports.select  { |report| report.active?  }
  end

  def inactive_reports
    @inactive_reports ||= reports.select  { |report| not report.active?  }
  end

  # the following three method returns set, all of which do not intersect each other, and together,
  # represent all of the reports
  def reports_not_assigned_to_a_grader
    @reports_not_assigned_to_a_grader ||= active_reports.select { |report| not report.has_grader? }
  end

  def active_reports_assigned_to_a_grader
    @active_reports_assigned_to_a_grader ||= active_reports.select { |report| report.has_grader? }
  end

  def graded_but_still_active_reports
    @graded_but_still_active_reports ||= active_reports_assigned_to_a_grader.select{ |report| report.graded? }
  end

  def most_recently_graded_active_report
    @most_recently_graded_active_report ||= lambda {
      most_recently_graded_active_report = nil
      graded_but_still_active_reports.each { |report|
        most_recently_graded_active_report = report if ( (most_recently_graded_active_report == nil) or (report.graded_at > most_recently_graded_active_report.graded_at) )
      }
      return most_recently_graded_active_report
    }.call
  end

  def reports_assigned_to_a_grader_but_ungraded
    @reports_assigned_to_a_grader_but_ungraded ||= active_reports_assigned_to_a_grader.select{ |report| not report.graded? }
  end

  def ungraded_reports
    @ungraded_reports ||= active_reports.select{ |report| not report.graded?}
  end

  def graded_active_reports
    @graded_active_reports ||= active_reports.select{ |report| report.graded?}
  end

  def graded_reports
    @graded_reports ||= reports.find_all { |report| report.graded? }
#    @graded_reports ||= reports.find(:all, :conditions => 'graded_at is not null')
  end


=begin

  def graded_reports_ordered_by_graded_at
    @graded_reports_ordered_by_graded_at ||= reports.find(:all, :conditions => 'graded_at is not null', :order => 'graded_at DESC')
#    @graded_reports_ordered_by_graded_at ||= graded_reports.find(:all, :conditions => {:order => 'graded_at DESC' })
  end

=end


  def average_grade_indefinite_article
    @average_grade_indefinite_article ||= Report.calculate_indefinite_article(average_grade)
  end

  def average_grade
    @average_grade ||=  lambda {
      return 'N/A' if graded_reports.empty?

      total_percentage = 0
      graded_reports.each do |report|
        total_percentage += report.percentage_grade
      end
      final_percentage = total_percentage / graded_reports.length
      return Report.calculate_letter_grade_from_percentage(final_percentage)
    }.call
  end

end
