class Student < User
  include HasReports

  has_many :reports,:order => 'graded_at desc, created_at desc'
#  has_many :reports, :order => 'graded_at desc, created_at desc'
  belongs_to :grade_level
  validates_presence_of :birth_date, :grade_level_id

  # validate grade level
  def validate
    super
    errors.add(:grade_level, "should be between 1 and 6") if grade_level == nil or grade_level.level < 1 or grade_level.level > 6
  end

  # todo: if an admin is logged in show full last name; else show
  def to_label
    "#{first_name} #{last_name}"
  end

  def to_s
    first_name_last_initial
  end

  def default_timezone
    "Seoul"
  end

  def grade_level_form_value=(level)
    self.grade_level = GradeLevel.get_grade_level(level.to_i)
  end

  def grade_level_form_value
    grade_level == nil ? nil : grade_level.level.to_s
  end

  def first_name_last_initial
    "#{first_name} #{last_name.slice(0,1)}."
  end

  def self.get_sample_student_of_grade_level(level)
    Student.find(:first,  :conditions =>   ["grade_level_id = ? AND sample = ? AND email REGEXP ? ", level, true, 'student_level_[0-9]@example.com' ])
  end
end