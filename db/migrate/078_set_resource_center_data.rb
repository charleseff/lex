class SetResourceCenterData < ActiveRecord::Migration
  def self.up

    add_column :resources, :file_name, :string

    ActiveRecord::Base.connection.insert("replace into resources (id, name, subheading, file_name) values
(1, 'Common Mistakes to Avoid', 'A list of grammar and spelling mistakes to watch out for.', 'common_mistakes_to_avoid'),
(2, 'How You Will Be Graded', 'Learn how the grader will evaluate your book report.', 'how_you_will_be_graded_(level_1-2)'),
(3, 'How You Will Be Graded', 'Learn how the grader will evaluate your book report.', 'how_you_will_be_graded_(level_3-4)'),
(4, 'How You Will Be Graded', 'Learn how the grader will evaluate your book report.', 'how_you_will_be_graded_(level_5-6)'),
(9, 'Guidelines for Writing a Strong 5-Paragraph Essay', 'Review this comprehensive guide about how you can write an effective book report.', 'guidelines_(level_3-6)'),
(10, 'Guidelines for Writing an Interesting Book Review', 'Review this comprehensive guide about how you can write an effective book report.', 'guidelines_(level_1-2)')")
    ActiveRecord::Base.connection.delete("delete from grade_levels_resources")

    ActiveRecord::Base.connection.insert("replace into grade_levels_resources (grade_level_id, resource_id) values
(1, 1),
(1, 2),
(1, 10),
(2, 1),
(2, 2),
(2, 10),
(3, 1),
(3, 3),
(3, 9),
(4, 1),
(4, 3),
(4, 9),
(5, 1),
(5, 4),
(5, 9),
(6, 1),
(6, 4),
(6, 9)")
  end

  def self.down
    remove_column :resources, :file_name
  end
end
