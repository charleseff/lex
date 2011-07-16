class CreateSampleReport < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.insert("
replace into users  (id, email, crypted_password, salt, created_at,
   type, first_name, last_name, grade_level_id, sample) values
(7,  'student_level_2@example.com',
    '595d958b2a9219f210f86abc838847c761954202', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
    '2007-09-20 16:34:05.0', 'Student', 'Olivia', 'Kang', 2, true )")
    ActiveRecord::Base.connection.insert("
replace into users  (id, email, crypted_password, salt, created_at,
   type, first_name, last_name, grade_level_id, sample) values
(8,  'student_level_2_not_for_students@example.com',
    '595d958b2a9219f210f86abc838847c761954202', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
    '2007-09-20 16:34:05.0', 'Student', 'John', 'Castillo', 2, true )")


    ActiveRecord::Base.connection.insert("replace into books (id, title, author) values
(1, 'Matilda', 'Roald Dahl')")

    ActiveRecord::Base.connection.delete("delete from reports where id <= 6")

    ActiveRecord::Base.connection.insert <<EOF
replace into reports  (id, student_id, grader_id, book_id, grader_comment,
   grader_was_warned, archive_notification_sent, created_at, updated_at, assigned_to_grader_at, grade_level_id, assignment_topic_id, last_saved_by_grader_at, graded_at) values
( 1, 7, 12, 1, 'Excellent book report! I enjoyed reading your book review. You only had one mistake. Next time, proofread one more time or ask a friend who''s read the book to lend a helping eye. Your supporting paragraphs are good, but I would discuss your story examples a little bit more. Roald Dahl is one of my favorite authors. I encourage you to read some of his other books too!',
 false, null, '2007-09-20 16:34:05.0', '2007-09-20 16:34:05.0', '2007-09-21 16:34:05.0',
 2, 1, '2007-09-22 16:34:05.0', '2007-09-23 16:34:05.0'),
( 2, 8, 12, 1, 'I enjoyed reading your book report! The two areas that you need to work on are finding examples from the story to support your supporting ideas and getting right to the gist of your plot summary (no more than 5 sentences!). Also, make sure to keep a consistent tense throughout your essay. I know this seems difficult, but this will come easier to you as you continue to write. Keep reading and writing!',
 false, null, '2007-09-20 16:34:05.0', '2007-09-20 16:34:05.0', '2007-09-21 16:34:05.0',
 2, 1, '2007-09-22 16:34:05.0', '2007-09-23 16:34:05.0')
EOF

    ActiveRecord::Base.connection.delete("delete from graded_ptal_task_items where id <= 18")


    ActiveRecord::Base.connection.insert("replace into graded_ptal_task_items  (id, report_id, ptal_task_item_id, points_earned) values
(1, 1, 15, 1),
(2, 1, 16, 5),
(3, 1, 17, 2),
(4, 1, 18, 4),
(5, 1, 19, 3),
(6, 1, 20, 4),
(7, 1, 21, 7),
(8, 1, 22, 3),
(9, 1, 23, 1),
(10, 1, 24, 6),
(11, 1, 25, 6),
(12, 1, 26, 3),
(13, 1, 27, 2),
(14, 1, 28, 2),
(15, 2, 15, 0),
(16, 2, 16, 5),
(17, 2, 17, 2),
(18, 2, 18, 4),
(19, 2, 19, 1),
(20, 2, 20, 4),
(21, 2, 21, 8),
(22, 2, 22, 3),
(23, 2, 23, 0),
(24, 2, 24, 6),
(25, 2, 25, 6),
(26, 2, 26, 2),
(27, 2, 27, 2),
(28, 2, 28, 0)")

  end

  def self.down
  end
end
