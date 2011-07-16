class AddLastSavedByGraderColumnToReports < ActiveRecord::Migration
  def self.up
       add_column :reports, :last_saved_by_grader_at, :datetime
  end

  def self.down
      remove_column :reports, :last_saved_by_grader_at
  end
end
