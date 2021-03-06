class CreateMorePtalData < ActiveRecord::Migration

  def self.up
    ActiveRecord::Base.connection.delete("delete from ptal_task_items")
    ActiveRecord::Base.connection.delete("delete from ptal_task_items_ptals")

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

    ActiveRecord::Base.connection.insert("replace into ptal_task_items_ptals (ptal_id, ptal_task_item_id) values
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

  end

  def self.down
    # not gonna attempt to reverse this migration, not necessary
  end
end
