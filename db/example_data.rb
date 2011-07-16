module FixtureReplacement
  
  def default_ptal_task_items
    return [default_ptal_task_item, default_ptal_task_item]
  end
  
  def default_assignment_topics
    return [default_assignment_topic, default_assignment_topic]
  end

  attributes_for :assignment_topic do |a|
    a.name = 'Book Review'
  end

  attributes_for :book do |a|

  end

  attributes_for :confirmation_code do |a|

  end

  attributes_for :dialog_message do |a|

  end

  attributes_for :doc do |a|

  end

  attributes_for :email_change_request do |a|

  end

  attributes_for :grade_level do |a|
    a.level = 1
    a.ptal_task_items = default_ptal_task_items
    a.assignment_topics = default_assignment_topics
  end

  attributes_for :graded_ptal_task_item do |a|

  end

  attributes_for :grading_failure do |a|

  end

  attributes_for :key_value_pair do |a|

  end

  attributes_for :pdf do |a|

  end

  attributes_for :ptal_task_item do |a|
    a.category = 'A. Structure'
    a.description = String.random
    a.possible_points = 1
=begin

    category: A. Structure
    description: Includes an appropriate title
    possible_points: 1

=end



  end

  attributes_for :report do |a|

  end

  # user ?
  attributes_for :student do |u|
    u.type                   = 'Student'
    u.email                  = "bobby@example.com"
    u.salt                   = '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8'
    u.crypted_password       = '595d958b2a9219f210f86abc838847c761954202'
    u.created_at             = 1.days.ago.to_s
    u.grade_level            = default_grade_level
    u.first_name             = 'charles'       # expects attributes_for :bar to be setup
    u.last_name              = 'finkel'
    u.birth_date             = 10.years.ago
    u.time_zone = 'Seoul'
    u.confirmed = true
=begin

      type: Student
      email: bobby@barrelny.com
      salt: 36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8
      crypted_password: 595d958b2a9219f210f86abc838847c761954202 # barrel
      created_at: <%= 1.days.ago.to_s :db %>
      grade_level: grade_level_4
      first_name: Bobby
      last_name: Kim
      birth_date: <%= 10.years.ago.to_s :db %>
      time_zone: Seoul
      confirmed: true

=end
  end

end