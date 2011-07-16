class ChangeDreamsAndWantsName < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.update("
update assignment_topics set name = 'Dreams and Goals'
where name = 'Dreams and Wants'")

  end

  def self.down
    ActiveRecord::Base.connection.update("
update assignment_topics set name = 'Dreams and Wants'
where name = 'Dreams and Goals'")
  end
end
