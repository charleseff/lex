class RemoveIdsFromCrossRefTables < ActiveRecord::Migration
  def self.up
    remove_column :graders_preferred_grade_levels, :id
  end

  def self.down
    add_column :graders_preferred_grade_levels, :id, :integer
  end
end
