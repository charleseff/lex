class RenamePtalToGradeLevel < ActiveRecord::Migration
  def self.up
    rename_table :ptals, :grade_levels
    rename_column :grade_levels, :grade_level, :level
    rename_table :ptal_task_items_ptals, :grade_levels_ptal_task_items
    rename_column :grade_levels_ptal_task_items, :ptal_id, :grade_level_id

    rename_column :reports, :grade_level, :grade_level_id
    rename_column :users, :grade_level, :grade_level_id

    # create index on column:
    add_index :grade_levels, :level
  end

  def self.down
    remove_index :grade_levels, :level

    rename_column :reports, :grade_level_id, :grade_level
    rename_column :users, :grade_level_id, :grade_level

    rename_column :grade_levels_ptal_task_items,  :grade_level_id, :ptal_id
    rename_table  :grade_levels_ptal_task_items, :ptal_task_items_ptals
    rename_column :grade_levels, :level, :grade_level
    rename_table :grade_levels, :ptals
  end
end
