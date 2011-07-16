class FixPtalData < ActiveRecord::Migration
  def self.up

    ActiveRecord::Base.connection.insert("replace into graded_ptal_task_items  (id, report_id, ptal_task_item_id, points_earned) values
(21, 2, 21, 5)")
  end

  def self.down
  end
end
