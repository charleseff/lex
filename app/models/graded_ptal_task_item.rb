class GradedPtalTaskItem < ActiveRecord::Base
  belongs_to :report
  validates_presence_of :report_id, :ptal_task_item_id, :points_earned
  belongs_to :ptal_task_item
  validates_uniqueness_of   :ptal_task_item_id, :scope => :report_id

end
