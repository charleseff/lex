class AddActivityDataToReport < ActiveRecord::Migration
  def self.up
    # the idea being that if a report has been graded and hasn't had activity is > ~48 hours or so,
    # then that report is considered inactive and dialogue between grader and student are now closed
    add_column :reports, :active, :boolean
    add_column :reports, :last_activity, :datetime
  end

  def self.down
    remove_column :reports, :active
    remove_column :reports, :last_activity
  end
end
