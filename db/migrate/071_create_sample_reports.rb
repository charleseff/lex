class CreateSampleReports < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.insert("replace into users  (id, email, crypted_password, salt, created_at,
   type, first_name, last_name, grade_level_id, sample) values
( 6,  'student_level_1@example.com',
'595d958b2a9219f210f86abc838847c761954202', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
'2007-09-20 16:34:05.0', 'Student', 'Test', 'Student', 1, true ),
( 7,  'student_level_2@example.com',
'595d958b2a9219f210f86abc838847c761954202', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
'2007-09-20 16:34:05.0', 'Student', 'Test', 'Student', 2, true ),
( 8,  'student_level_3@example.com',
'595d958b2a9219f210f86abc838847c761954202', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
'2007-09-20 16:34:05.0', 'Student', 'Test', 'Student', 3, true ),
( 9,  'student_level_4@example.com',
'595d958b2a9219f210f86abc838847c761954202', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
'2007-09-20 16:34:05.0', 'Student', 'Test', 'Student', 4, true ),
( 10,  'student_level_5@example.com',
'595d958b2a9219f210f86abc838847c761954202', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
'2007-09-20 16:34:05.0', 'Student', 'Test', 'Student', 5, true ),
( 11,  'student_level_6@example.com',
'595d958b2a9219f210f86abc838847c761954202', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
'2007-09-20 16:34:05.0', 'Student', 'Test', 'Student', 6, true ),
( 12,  'sample_grader@example.com',
'595d958b2a9219f210f86abc838847c761954202', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
'2007-09-20 16:34:05.0', 'Grader', 'Test', 'Grader', null, true )
")

    ActiveRecord::Base.connection.insert("replace into books (id, title, author) values
(1, 'Title', 'Author')")

    ActiveRecord::Base.connection.insert("replace into reports  (id, student_id, grader_id, book_id, grader_comment,
   grader_was_warned, archive_notification_sent, created_at, updated_at, assigned_to_grader_at, grade_level_id, assignment_topic_id, last_saved_by_grader_at, graded_at) values
( 1, 6, 12, 1, 'Good job', false, null, '2007-09-20 16:34:05.0', '2007-09-20 16:34:05.0', '2007-09-21 16:34:05.0',
 1, 1, '2007-09-22 16:34:05.0', '2007-09-23 16:34:05.0'),
( 2, 7, 12, 1, 'Good job', false, null, '2007-09-20 16:34:05.0', '2007-09-20 16:34:05.0', '2007-09-21 16:34:05.0',
 2, 1, '2007-09-22 16:34:05.0', '2007-09-23 16:34:05.0'),
( 3, 8, 12, 1, 'Good job', false, null, '2007-09-20 16:34:05.0', '2007-09-20 16:34:05.0', '2007-09-21 16:34:05.0',
 3, 1, '2007-09-22 16:34:05.0', '2007-09-23 16:34:05.0'),
( 4, 9, 12, 1, 'Good job', false, null, '2007-09-20 16:34:05.0', '2007-09-20 16:34:05.0', '2007-09-21 16:34:05.0',
 4, 1, '2007-09-22 16:34:05.0', '2007-09-23 16:34:05.0'),
( 5, 10, 12, 1, 'Good job', false, null, '2007-09-20 16:34:05.0', '2007-09-20 16:34:05.0', '2007-09-21 16:34:05.0',
 5, 1, '2007-09-22 16:34:05.0', '2007-09-23 16:34:05.0'),
( 6, 11, 12, 1, 'Good job', false, null, '2007-09-20 16:34:05.0', '2007-09-20 16:34:05.0', '2007-09-21 16:34:05.0',
 6, 1, '2007-09-22 16:34:05.0', '2007-09-23 16:34:05.0')")

    ActiveRecord::Base.connection.insert("replace into graded_ptal_task_items  (id, report_id, ptal_task_item_id, points_earned) values
(1, 5, 29, 1),
(2, 5, 30, 1),
(3, 5, 31, 1),
(4, 5, 32, 1),
(5, 5, 33, 1),
(6, 5, 34, 1),
(7, 5, 35, 1),
(8, 5, 36, 1),
(91, 5, 37, 1),
(10, 5, 38, 1),
(11, 5, 39, 1),
(12, 5, 40, 1),
(13, 5, 41, 1),
(14, 5, 42, 1),
(15, 5, 43, 1),
(16, 5, 44, 1),
(17, 5, 45, 1),
(18, 5, 46, 1)")

  end

  def self.down
  end
end

