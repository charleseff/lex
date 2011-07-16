class CreateGradersToGradeLevelsCrossRefTable < ActiveRecord::Migration
  def self.up
    create_table :grade_levels_graders do |t|
      t.references :grade_level, :grader, :null => false
      t.timestamps
    end
    add_index :grade_levels_graders, :grader_id

    # also gotta get rid of preferred_grade_levels column:
    remove_column :users, :preferred_grade_levels

    # also, add an index to grade_levels_ptal_task_items
    add_index :grade_levels_ptal_task_items, :grade_level_id

  end

  def self.down
    remove_index :grade_levels_ptal_task_items, :grade_level_id

    add_column :users, :preferred_grade_levels, :integer
    drop_table :grade_levels_graders
  end
end
