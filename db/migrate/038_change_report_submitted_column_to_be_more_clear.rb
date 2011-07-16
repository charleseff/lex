class ChangeReportSubmittedColumnToBeMoreClear < ActiveRecord::Migration
  def self.up
    rename_column :reports, :submitted, :time_submitted
    rename_column :reports, :last_activity, :time_of_last_activity
  end

  def self.down
    rename_column :reports, :time_submitted, :submitted
    rename_column :reports, :time_of_last_activity, :last_activity
  end
end
