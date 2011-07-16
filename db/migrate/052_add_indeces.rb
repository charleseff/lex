class AddIndeces < ActiveRecord::Migration
  def self.up
    add_index :reports, :time_submitted
    add_index :ptal_task_items_ptals, :ptal_id
    add_index :books, :title
    add_index :books, :author

    add_index :reports, :graded
    add_index :reports, :grader_id
    add_index :reports, :time_of_last_activity
    add_index :reports, :grader_was_warned
  end

  def self.down
    remove_index :reports, :time_submitted
#    remove_index :ptal_task_items_ptals, :ptal_id
    
    remove_index :books, :title
    remove_index :books, :author

    remove_index :reports, :graded
    remove_index :reports, :grader_id
    remove_index :reports, :time_of_last_activity
    remove_index :reports, :grader_was_warned

  end
end
