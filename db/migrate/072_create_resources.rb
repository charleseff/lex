class CreateResources < ActiveRecord::Migration
  def self.up

    create_table :resources do |t|
      t.string :name, :subheading
      t.timestamps
    end

    create_table :grade_levels_resources, :id => false do |t|
      t.references :grade_level, :resource, :null => false
    end

    add_index :grade_levels_resources, :grade_level_id
    add_index :grade_levels_resources, :resource_id

    # todo: COMPLETE THIS:
    ActiveRecord::Base.connection.insert("replace into resources (id, name, subheading) values
(1, 'Common Mistakes to Avoid (Grade Level 5)', 'A list of grammar and spelling mistakes to watch out for.'),
(2, 'Formatting Rules', 'Make sure your book report is written correctly before you submit.'),
(3, 'How You''ll Be Graded (Grade Level 5)', 'Learn how the grader will evaluate your book report.')
")

    ActiveRecord::Base.connection.insert("replace into grade_levels_resources (grade_level_id, resource_id) values
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(2, 3),
(3, 1),
(3, 2),
(3, 3),
(4, 1),
(4, 2),
(4, 3),
(5, 1),
(5, 2),
(5, 3),
(6, 1),
(6, 2),
(6, 3)
")


  end

  def self.down
    drop_table :resources
    drop_table :grade_levels_resources
  end
end
