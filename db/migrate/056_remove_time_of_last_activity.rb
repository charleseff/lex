class RemoveTimeOfLastActivity < ActiveRecord::Migration
  def self.up
    remove_column :reports, :time_of_last_activity

    add_column :reports, :assigned_to_grader_at, :datetime
    add_index :reports, :assigned_to_grader_at
  end

  def self.down
    add_column :reports, :time_of_last_activity, :datetime
    add_index :reports, :time_of_last_activity

    remove_column :reports, :assigned_to_grader_at
  end
end
