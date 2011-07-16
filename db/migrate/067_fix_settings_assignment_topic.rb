class FixSettingsAssignmentTopic < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.insert("replace into assignment_topics (id, name) values
(3, 'Settings')")

  end

  def self.down
    ActiveRecord::Base.connection.insert("replace into assignment_topics (id, name) values
(3, 'Setting')")
  end
end
