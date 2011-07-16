
class GradeLevel < ActiveRecord::Base
  has_many :ptal_task_items, :order => 'display_order'
  has_many :students
#  has_and_belongs_to_many :graders
  has_and_belongs_to_many :assignment_topics
  has_and_belongs_to_many :resources

  # returns a hash.  key = category_name.  value = another hash with keys:
  #    :possible_points (total possible points for this category), :task_items
  def ptal_categories
    @ptal_categories ||= create_ptal_categories
  end

  def total_possible_points
    @total_possible_points ||= create_total_possible_points
  end

  def self.get_grade_level(level)
    find_by_level(level)
  end

  def self.american_to_lex_kim(n)
    n-2
  end

  def self.lex_kim_to_american(n)
    n+2
  end

  # grade levels are equal if their levels are equal (duh)
  def ==(other_grade_level)
    return false if not other_grade_level.is_a? GradeLevel
    return true if other_grade_level.level == level
    return false
  end

  def sample_student
    @sample_student ||= Student.get_sample_student_of_grade_level(level)
  end

  def to_label
    level
  end
  
  private
  def create_ptal_categories
    categories = {}
    ptal_task_items.each do |task_item|
      category = task_item.category
      categories[category] = {:possible_points_subtotal => 0, :task_items => []} if categories[category].nil?
      categories[category][:possible_points_subtotal] += task_item.possible_points
      categories[category][:task_items] << task_item
    end
    categories
  end

  def create_total_possible_points
    total_possible_points = 0
    ptal_categories.each_value do | category|
      total_possible_points += category[:possible_points_subtotal]
    end
    total_possible_points
  end

end
