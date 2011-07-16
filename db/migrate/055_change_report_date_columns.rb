class ChangeReportDateColumns < ActiveRecord::Migration
  def self.up
    add_column :reports, :created_at, :datetime
    add_column :reports, :updated_at, :datetime
    add_index :reports, :created_at

    # replace graded boolean with graded_at time (report.graded? check will check graded_at time)
    remove_column :reports, :time_submitted
    add_column :reports, :graded_at, :datetime
    add_index :reports, :graded_at
    remove_column :reports, :graded
  end

  def self.down
    remove_column :reports, :created_at
    remove_column :reports, :updated_at

    add_column :reports, :time_submitted, :datetime
    add_index :reports, :time_submitted
    remove_column :reports, :graded_at
    add_column :reports, :graded, :boolean, :default => false
    add_index :reports, :graded
  end
end
