class CreateAssignmentTopics < ActiveRecord::Migration
  def self.up

    create_table :assignment_topics do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :assignment_topics_grade_levels, :id => false do |t|
      t.references :assignment_topic, :grade_level, :null => false
      t.integer :option
      t.timestamps
    end

    add_index :assignment_topics_grade_levels, :assignment_topic_id
    add_index :assignment_topics_grade_levels, :grade_level_id

    ActiveRecord::Base.connection.insert("replace into assignment_topics (id, name) values
(1, 'Book Review'),
(2, 'Character Development'),
(3, 'Setting'),
(4, 'Dreams and Wants'),
(5, 'Relationships'),
(6, 'Symbolism'),
(7, 'Positive and Negative Portrayal')")

    ActiveRecord::Base.connection.insert("replace into assignment_topics_grade_levels (grade_level_id,assignment_topic_id) values
(1, 1),
(2, 1),
(3, 2),
(3, 3),
(3, 4),
(4, 2),
(4, 3),
(4, 4),
(5, 5),
(5, 6),
(5, 7),
(6, 5),
(6, 6),
(6, 7)")
  end

  def self.down
    drop_table :assignment_topics
    drop_table :assignment_topics_grade_levels
  end
end
