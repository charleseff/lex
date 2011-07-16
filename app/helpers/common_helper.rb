module CommonHelper

  def substitute_breaks(string)
    return string if string == nil
    return string.gsub(/\n/, '<br>')
  end

  def substitute_paragraphs(string)
    return string if string == nil
    return h(string).gsub(/(.+)\Z/, '<p>\1</p>').gsub(/(.*)\n/, '<p>\1</p>')
  end

  def convert_date(date)
    date.strftime('%b %d, %Y')
  end

  def convert_date_full_month(date)
    date.strftime('%B %d, %Y')
  end

  def convert_date_time(date)
    date.strftime('%b %d, %Y %l:%M%p')
  end

  def convert_date_time_full_month(date)
    date.strftime('%B %d, %Y %l:%M%p')
  end

  def image_icon(report_type)
    image_icon = (report_type == 'submitted' or report_type == 'grader_ungraded') ? 'bookreportungraded_icon.gif' : report_type == 'graded' ? 'bookreportgraded_icon.gif' : 'bookreportarchived_icon.gif'
  end

  def is_student?
    current_user.is_a? Student
  end
  
  def is_grader?
    current_user.is_a? Grader
  end

  def is_administrator?
    current_user.is_a? Administrator
  end

end