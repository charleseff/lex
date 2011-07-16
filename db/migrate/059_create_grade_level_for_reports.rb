class CreateGradeLevelForReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :grade_level, :integer
  end

  def self.down
    remove_column :reports, :grade_level
  end
end
