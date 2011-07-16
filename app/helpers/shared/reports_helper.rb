module Shared::ReportsHelper
  def sub_page_title
    title = "#{@report.book.title} by #{@report.book.author}"
    unless is_student?
      if is_grader?
        title << " (by #{@report.student.first_name_last_initial}"
      else
        title << " (by #{@report.student.full_name}"
      end
      title << ", Grade #{GradeLevel.lex_kim_to_american(@report.grade_level.level)})"
    end
    return title
  end

  def top_right_link
    if is_administrator?
      link_to 'Return to Reports list', :controller => '/admin/reports', :action => :index
    else
      link_to 'Return to Home', root_path
    end
  end
end