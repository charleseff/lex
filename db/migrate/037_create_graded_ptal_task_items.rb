class CreateGradedPtalTaskItems < ActiveRecord::Migration
  def self.up
    create_table :graded_ptal_task_items do |t|
      t.column :report_id, :int
      t.column :ptal_task_item_id, :int
      t.column :points_earned, :string
      t.column :comment, :string
    end
  end

  def self.down
    drop_table :graded_ptal_task_items
  end
end
