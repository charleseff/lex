class Grader < User
  include HasReports
  has_many :grading_failures
  has_many :reports, :order => 'graded_at desc'
  has_and_belongs_to_many :preferred_grade_levels, :class_name => 'GradeLevel', :join_table => 'graders_preferred_grade_levels'

  def to_label
    "#{first_name} #{last_name}"
  end

  def to_s
    "#{first_name} #{last_name.slice(0,1)}."
  end

  def can_grade_another_report
    ungraded_reports.empty?
  end

  def failed_to_grade(report)
=begin
    report.grading_failures.each do |failures|
      if failures.grader == self
        return true
      end
    end
=end
    grading_failures.each do |failures|
      if failures.report == report
        return true
      end
    end

    false
  end

  def preferred_grade_level_form_hash
    @preferred_grade_level_form_hash ||= create_preferred_grade_level_form_hash
  end

  def prefers_grade_level(grade_level)
    preferred_grade_levels.detect{ |this_grade_level| this_grade_level.level == grade_level }
  end

  protected

  def default_timezone
    "Eastern Time (US & Canada)"
  end

  def preferred_grade_level_form_hash=(checkboxes)
    preferred_grade_levels_old = preferred_grade_levels.clone

    preferred_grade_levels_old.each do |grade_level|
      if checkboxes.detect {|checkbox_value| checkbox_value == grade_level.level.to_s}
        checkboxes.delete grade_level.level.to_s
      else
        preferred_grade_levels.delete grade_level
      end
    end

    checkboxes.each do |checkbox_value|
      preferred_grade_levels <<  GradeLevel.get_grade_level(checkbox_value.to_i)
    end

    @preferred_grade_level_form_hash = nil

  end

  private
  def create_preferred_grade_level_form_hash
    preferred_grade_level_form_hash = {}
    preferred_grade_levels.each do |grade_level|
      preferred_grade_level_form_hash[grade_level.level] = '1'
    end
    return preferred_grade_level_form_hash
  end

end
