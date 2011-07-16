class RenamePreferredGradeLevelsJoinTable < ActiveRecord::Migration
  def self.up
    rename_table :grade_levels_graders, :graders_preferred_grade_levels
  end

  def self.down
    rename_table :graders_preferred_grade_levels, :grade_levels_graders
  end
end
