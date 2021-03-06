class ChangePtalsToRemoveCrossrefTable < ActiveRecord::Migration
  def self.up
    drop_table :grade_levels_ptal_task_items

    add_column :ptal_task_items, :grade_level_id, :integer
    add_column :ptal_task_items, :display_order, :integer

    ActiveRecord::Base.connection.delete("delete from ptal_task_items")

    ActiveRecord::Base.connection.insert("replace into ptal_task_items (id, grade_level_id, display_order,
category, description, possible_points) values
(1, 1, 1, 'A. Structure', 'Includes an appropriate title', 1 ),
(2, 1, 2, 'A. Structure', 'Essay is divided into five paragraphs: an introduction, a plot summary, two supporting paragraphs, and a conclusion', 5),
(3, 1, 3, 'B. Content', 'Introduction provides a brief overview of the story', 2 ),
(4, 1, 4, 'B. Content', 'Student’s thesis is clear and original and expresses his or her opinion about the book', 4 ),
(5, 1, 5, 'B. Content', 'Plot summary captures the important story elements without going into too much detail', 3 ),
(6, 1, 6, 'B. Content', 'Supporting paragraphs have clear topic sentences that provide a focus for the paragraph', 4 ),
(7, 1, 7, 'B. Content', 'Supporting paragraphs discuss specific examples from the story (2-3 for each paragraph)
', 8 ),
(8, 1, 8, 'B. Content', 'Conclusion restates the thesis and summarizes the supporting paragraphs', 3 ),
(9, 1, 9, 'B. Content', '# Conclusion recommends the book to a specific group of readers', 1 ),
(10, 1, 10, 'C. Style and Mechanics', 'Student writes in complete sentences (avoids run-ons and fragments)', 6 ),
(11, 1, 11, 'C. Style and Mechanics', 'Student’s use of punctuation is correct and appropriate', 6 ),
(12, 1, 12, 'C. Style and Mechanics', 'Student’s word choice is thoughtful and accurate', 3 ),
(13, 1, 13, 'C. Style and Mechanics', 'Student correctly capitalizes words', 2 ),
(14, 1, 14, 'C. Style and Mechanics', 'Student maintains a consistent tense (the present tense) throughout the work', 2 ),
(15, 2, 1, 'A. Structure', 'Includes an appropriate title', 1 ),
(16, 2, 2, 'A. Structure', 'Essay is divided into five paragraphs: an introduction, a plot summary, two supporting paragraphs, and a conclusion', 5),
(17, 2, 3, 'B. Content', 'Introduction provides a brief overview of the story', 2 ),
(18, 2, 4, 'B. Content', 'Student’s thesis is clear and original and expresses his or her opinion about the book', 4 ),
(19, 2, 5, 'B. Content', 'Plot summary captures the important story elements without going into too much detail', 3 ),
(20, 2, 6, 'B. Content', 'Supporting paragraphs have clear topic sentences that provide a focus for the paragraph', 4 ),
(21, 2, 7, 'B. Content', 'Supporting paragraphs discuss specific examples from the story (2-3 for each paragraph)
', 8 ),
(22, 2, 8, 'B. Content', 'Conclusion restates the thesis and summarizes the supporting paragraphs', 3 ),
(23, 2, 9, 'B. Content', '# Conclusion recommends the book to a specific group of readers', 1 ),
(24, 2, 10, 'C. Style and Mechanics', 'Student writes in complete sentences (avoids run-ons and fragments)', 6 ),
(25, 2, 11, 'C. Style and Mechanics', 'Student’s use of punctuation is correct and appropriate', 6 ),
(26, 2, 12, 'C. Style and Mechanics', 'Student’s word choice is thoughtful and accurate', 3 ),
(27, 2, 13, 'C. Style and Mechanics', 'Student correctly capitalizes words', 2 ),
(28, 2, 14, 'C. Style and Mechanics', 'Student maintains a consistent tense (the present tense) throughout the work', 2 ),
(29, 5, 1, 'A. Structure', 'Includes an appropriate title', 1 ),
(30, 5, 2, 'A. Structure', 'Essay is divided into five paragraphs: an introduction, three supporting paragraphs, and a conclusion', 5),
(31, 5, 3, 'B. Content', 'Introduction provides a brief overview of the story', 2),
(32, 5, 4, 'B. Content', 'Introduction includes a thesis that is clear and original', 5),
(33, 5, 5, 'B. Content', 'Supporting paragraphs have clear topic sentences that provide a focus for the', 3),
(34, 5, 6, 'B. Content', 'Supporting paragraphs give specific examples from the story (3 for each paragraph) that support the thesi', 9),
(35, 5, 7, 'B. Content', 'Supporting paragraphs offer discussion and analysis of the three specific examples', 9),
(36, 5, 8, 'B. Content', 'Conclusion restates the thesis', 2),
(37, 5, 9, 'B. Content', 'Conclusion summarizes the topics of the supporting paragraphs', 2),
(38, 5, 10, 'B. Content', 'Conclusion explains why the thesis is important to the larger story', 1),
(39, 5, 11, 'C. Style and Mechanics', 'Student writes in complete sentences (avoids run-ons and fragments)', 5),
(40, 5, 12, 'C. Style and Mechanics', 'Students varies sentence structure (uses both simple and complex)', 3),
(41, 5, 13, 'C. Style and Mechanics', 'Student’s use of punctuation is correct and appropriate', 3),
(42, 5, 14, 'C. Style and Mechanics', 'Student correctly capitalizes words', 2),
(43, 5, 15, 'C. Style and Mechanics', 'Student’s word choice is accurate', 3),
(44, 5, 16, 'C. Style and Mechanics', 'Student writes in the third person (does not use “I” or “You”)', 1),
(45, 5, 17, 'C. Style and Mechanics', 'Student uses transition words between supporting paragraphs', 2),
(46, 5, 18, 'C. Style and Mechanics', 'Student maintains a consistent tense (the present tense) throughout the work', 2),
(47, 6, 1, 'A. Structure', 'Includes an appropriate title', 1 ),
(48, 6, 2, 'A. Structure', 'Essay is divided into five paragraphs: an introduction, three supporting paragraphs, and a conclusion', 5),
(49, 6, 3, 'B. Content', 'Introduction provides a brief overview of the story', 2),
(50, 6, 4, 'B. Content', 'Introduction includes a thesis that is clear and original', 5),
(51, 6, 5, 'B. Content', 'Supporting paragraphs have clear topic sentences that provide a focus for the', 3),
(52, 6, 6, 'B. Content', 'Supporting paragraphs give specific examples from the story (3 for each paragraph) that support the thesi', 9),
(53, 6, 7, 'B. Content', 'Supporting paragraphs offer discussion and analysis of the three specific examples', 9),
(54, 6, 8, 'B. Content', 'Conclusion restates the thesis', 2),
(55, 6, 9, 'B. Content', 'Conclusion summarizes the topics of the supporting paragraphs', 2),
(56, 6, 10, 'B. Content', 'Conclusion explains why the thesis is important to the larger story', 1),
(57, 6, 11, 'C. Style and Mechanics', 'Student writes in complete sentences (avoids run-ons and fragments)', 5),
(58, 6, 12, 'C. Style and Mechanics', 'Students varies sentence structure (uses both simple and complex)', 3),
(59, 6, 13, 'C. Style and Mechanics', 'Student’s use of punctuation is correct and appropriate', 3),
(60, 6, 14, 'C. Style and Mechanics', 'Student correctly capitalizes words', 2),
(61, 6, 15, 'C. Style and Mechanics', 'Student’s word choice is accurate', 3),
(62, 6, 16, 'C. Style and Mechanics', 'Student writes in the third person (does not use “I” or “You”)', 1),
(63, 6, 17, 'C. Style and Mechanics', 'Student uses transition words between supporting paragraphs', 2),
(64, 6, 18, 'C. Style and Mechanics', 'Student maintains a consistent tense (the present tense) throughout the work', 2),
(65, 3, 1, 'A. Structure', 'Includes an appropriate title', 1),
(66, 3, 2, 'A. Structure', 'Essay is divided into five paragraphs: an introduction, three supporting paragraphs, and a conclusion', 5),
(67, 3, 3, 'B. Content', 'Introduction provides a brief overview of the story', 2),
(68, 3, 4, 'B. Content', 'Introduction includes a thesis that is clear and original', 4),
(69, 3, 5, 'B. Content', 'Supporting paragraphs have clear topic sentences that provide a focus for the paragraph', 3),
(70, 3, 6, 'B. Content', 'Supporting paragraphs give specific examples from the story (3 for each paragraph) that support the thesis', 9),
(71, 3, 7, 'B. Content', 'Supporting paragraphs offer discussion and analysis of the three specific examples', 9),
(72, 3, 8, 'B. Content', 'Conclusion restates the thesis', 2),
(73, 3, 9, 'B. Content', 'Conclusion summarizes the topics of the supporting paragraphs', 2),
(74, 3, 10, 'B. Content', 'Conclusion explains why the thesis is important to the larger story', 2),
(75, 3, 11, 'C. Style and Mechanics', 'Student writes in complete sentences (avoids run-ons and fragments)', 6),
(76, 3, 12, 'C. Style and Mechanics', 'Student’s use of punctuation is correct and appropriate', 5),
(77, 3, 13, 'C. Style and Mechanics', 'Student correctly capitalizes words', 2),
(78, 3, 14, 'C. Style and Mechanics', 'Student’s word choice is accurate', 3),
(79, 3, 15, 'C. Style and Mechanics', 'Student writes in the third person (does not use “I” or “You”)', 1),
(80, 3, 16, 'C. Style and Mechanics', 'Student uses transition words between supporting paragraphs', 2),
(81, 3, 17, 'C. Style and Mechanics', 'Student maintains a consistent tense (the present tense) throughout the work', 2),
(82, 4, 1, 'A. Structure', 'Includes an appropriate title', 1),
(83, 4, 2, 'A. Structure', 'Essay is divided into five paragraphs: an introduction, three supporting paragraphs, and a conclusion', 5),
(84, 4, 3, 'B. Content', 'Introduction provides a brief overview of the story', 2),
(85, 4, 4, 'B. Content', 'Introduction includes a thesis that is clear and original', 4),
(86, 4, 5, 'B. Content', 'Supporting paragraphs have clear topic sentences that provide a focus for the paragraph', 3),
(87, 4, 6, 'B. Content', 'Supporting paragraphs give specific examples from the story (3 for each paragraph) that support the thesis', 9),
(88, 4, 7, 'B. Content', 'Supporting paragraphs offer discussion and analysis of the three specific examples', 9),
(89, 4, 8, 'B. Content', 'Conclusion restates the thesis', 2),
(90, 4, 9, 'B. Content', 'Conclusion summarizes the topics of the supporting paragraphs', 2),
(91, 4, 10, 'B. Content', 'Conclusion explains why the thesis is important to the larger story', 2),
(92, 4, 11, 'C. Style and Mechanics', 'Student writes in complete sentences (avoids run-ons and fragments)', 6),
(93, 4, 12, 'C. Style and Mechanics', 'Student’s use of punctuation is correct and appropriate', 5),
(94, 4, 13, 'C. Style and Mechanics', 'Student correctly capitalizes words', 2),
(95, 4, 14, 'C. Style and Mechanics', 'Student’s word choice is accurate', 3),
(96, 4, 15, 'C. Style and Mechanics', 'Student writes in the third person (does not use “I” or “You”)', 1),
(97, 4, 16, 'C. Style and Mechanics', 'Student uses transition words between supporting paragraphs', 2),
(98, 4, 17, 'C. Style and Mechanics', 'Student maintains a consistent tense (the present tense) throughout the work', 2)
")
  end

  
  def self.down
    ActiveRecord::Base.connection.insert("replace into ptal_task_items (id, category, description, possible_points) values
(1, 'A. Structure', 'Includes an appropriate title', 1),
(2, 'A. Structure', 'Essay is divided into five paragraphs: an introduction, three supporting paragraphs, and a conclusion', 5),
(3, 'B. Content', 'Introduction provides a brief overview of the story', 2),
(4, 'B. Content', 'Introduction includes a thesis that is clear and original', 5),
(5, 'B. Content', 'Supporting paragraphs have clear topic sentences that provide a focus for the paragraph', 3),
(6, 'B. Content', 'Supporting paragraphs give specific examples from the story (3 for each paragraph) that support the thesis', 9),
(7, 'B. Content', 'Supporting paragraphs discuss and analyze the three specific examples', 9),
(8, 'B. Content', 'Conclusion restates the thesis', 2),
(9, 'B. Content', 'Conclusion summarizes the topics of the supporting paragraphs', 2),
(10, 'B. Content', 'Conclusion connects the thesis topic to the overall story', 1),
(11, 'C. Style and Mechanics', 'Student writes in complete sentences (avoids run-ons and fragments)', 6),
(12, 'C. Style and Mechanics', 'Student uses correct punctuation', 5),
(13, 'C. Style and Mechanics', 'Student’s word choice is insightful and accurate', 3),
(14, 'C. Style and Mechanics', 'Student writes in the third person (does not use “I” or “You”)', 1),
(15, 'C. Style and Mechanics', 'Student uses transition words between supporting paragraphs', 2),
(16, 'C. Style and Mechanics', 'Student correctly capitalizes words', 2),
(17, 'C. Style and Mechanics', 'Student maintains a consistent tense (the present tense) throughout the work', 2),
(18, 'C. Style and Mechanics', 'Student writes in complete sentences (avoids run-ons and fragments)', 5),
(19, 'C. Style and Mechanics', 'Students varies sentence structure (uses both simple and complex)', 3),
(20, 'C. Style and Mechanics', 'Student uses correct punctuation', 3),
(21, 'B. Content', 'Thesis is clear and original', 5),
(22, 'B. Content', 'Plot summary provides a brief overview of the story without going into too much detail', 3),
(23, 'B. Content', 'Supporting paragraphs have clear topic sentences that provide a focus for the paragraph', 4),
(24, 'B. Content', 'Supporting paragraphs give specific examples from the story (2-3 for each paragraph)', 8),
(25, 'B. Content', 'Conclusion restates the thesis and provides a brief overview of the main supporting points', 3),
(26, 'C. Style and Mechanics', 'Student uses correct punctuation', 6),
(27, 'C. Style and Mechanics', 'Student’s word choice is thoughtful and accurate', 3),
(28, 'C. Style and Mechanics', 'Student correctly capitalizes words', 2)
")

    create_table :grade_levels_ptal_task_items, :force => true, :id => false  do |t|
      t.column :grade_level_id, :int,  :null => false
      t.column :ptal_task_item_id, :int, :null => false
    end
    add_index :grade_levels_ptal_task_items, :grade_level_id

    ActiveRecord::Base.connection.insert("replace into grade_levels_ptal_task_items (grade_level_id, ptal_task_item_id) values
(1, 1),
(2, 1),
(1, 2),
(2, 2),
(1, 3),
(2, 3),
(1, 21),
(2, 21),
(1, 22),
(2, 22),
(1, 23),
(2, 23),
(1, 24),
(2, 24),
(1, 25),
(2, 25),
(1, 11),
(2, 11),
(1, 26),
(2, 26),
(1, 17),
(2, 17),
(1, 27),
(2, 27),
(1, 28),
(2, 28),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
(3, 6),
(3, 7),
(3, 8),
(3, 9),
(3, 10),
(3, 11),
(3, 12),
(3, 13),
(3, 14),
(3, 15),
(3, 16),
(3, 17),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
(4, 6),
(4, 7),
(4, 8),
(4, 9),
(4, 10),
(4, 11),
(4, 12),
(4, 13),
(4, 14),
(4, 15),
(4, 16),
(4, 17),
(5, 1),
(6, 1),
(5,2),
(6,2),
(5,3),
(6,3),
(5,4),
(6,4),
(5,5),
(6,5),
(5,6),
(6,6),
(5,7),
(6,7),
(5,8),
(6,8),
(5,9),
(6,9),
(5,10),
(6,10),
(5,18),
(6,18),
(5,19),
(6,19),
(5,20),
(6,20),
(5,13),
(6,13),
(5,14),
(6,14),
(5,15),
(6,15),
(5,16),
(6,16),
(5,17),
(6,17)
")

    remove_column :ptal_task_items, :grade_level_id
    remove_column :ptal_task_items, :display_order


  end
end
