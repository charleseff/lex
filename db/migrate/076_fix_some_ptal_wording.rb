class FixSomePtalWording < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.update("
update ptal_task_items set description = 'Conclusion recommends the book to a specific group of readers' where
description = '# Conclusion recommends the book to a specific group of readers'")
  end

  def self.down
    ActiveRecord::Base.connection.update("
update ptal_task_items set description = '# Conclusion recommends the book to a specific group of readers' where
description = 'Conclusion recommends the book to a specific group of readers'")
  end
end
