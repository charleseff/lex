class CreatePtalTaskItems < ActiveRecord::Migration
  def self.up
    create_table :ptal_task_items do |t|
      t.column :category, :string
      t.column :description, :string
      t.column :possible_points, :int
    end

    ActiveRecord::Base.connection.insert("replace into ptal_task_items (id, category, description, possible_points) values
(1, 'A. Structure', 'Includes an appropriate title', 1),
(2, 'A. Structure', 'Length does not exceed 3 pages', 1),
(3, 'A. Structure', 'Clear introduction, conclusion, and at least two supporting paragraphs', 4),
(4, 'A. Structure', 'Thesis is clearly stated in the introductory paragraph', 2),
(5, 'A. Structure', 'Topic sentences for supporting paragraphs provide an overview of the paragraph', 4),
(6, 'B. Content', 'Supporting paragraphs develop the thesis', 4),
(7, 'B. Content', 'At least five supporting details or examples from the book are discussed in supporting paragraphs', 15),
(8, 'B. Content', 'Introduction provides a brief plot summary', 2),
(9, 'B. Content', 'Conclusion summarizes the main points supporting the thesis', 2),
(10, 'C. Style', 'Thesis offers an interesting analysis of the book', 3),
(11, 'C. Style', 'Writer''s voice is original', 3),
(12, 'C. Style', 'Writer balances story details with his or her analysis', 3),
(13, 'D. Mechanics', 'Student writes in complete sentences (avoids run-ons and fragments) with few errors.', 2),
(14, 'D. Mechanics', 'Student uses correct punctuation with few errors.', 2),
(15, 'D. Mechanics', 'Student maintains a consistent tense (the present tense) throughout the work', 2)")
  end

  def self.down
    drop_table :ptal_task_items
  end
end
