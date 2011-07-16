require "#{File.dirname(__FILE__)}/../test_helper"

module CommonIntegrationTest

  def login_as(user)
    post_via_redirect '/account/login', :email => user.email, :password => 'barrel'
  end

  def create_mock_ptal_data (report)
    hash = {}
    report.grade_level.ptal_task_items.each do |ptal_task_item|
      hash["graded_ptal_task_item_#{ptal_task_item.id}"] = {}
      hash["graded_ptal_task_item_#{ptal_task_item.id}"][:points_earned] = "1"
    end
    hash
  end

  def create_incomplete_mock_ptal_data (report)
    hash = {}
    first = true
    report.grade_level.ptal_task_items.each do |ptal_task_item|
      if first
        first = false
      else
        hash["graded_ptal_task_item_#{ptal_task_item.id}"] = {}
        hash["graded_ptal_task_item_#{ptal_task_item.id}"][:points_earned] = "1"
      end

    end
    hash
  end

end