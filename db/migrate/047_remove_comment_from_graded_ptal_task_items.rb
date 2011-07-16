class RemoveCommentFromGradedPtalTaskItems < ActiveRecord::Migration
  def self.up
    remove_column :graded_ptal_task_items, :comment
  end

  def self.down
    add_column :graded_ptal_task_items, :comment, :string

  end
end
