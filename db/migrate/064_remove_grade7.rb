class RemoveGrade7 < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.insert("delete from grade_levels where level = 7")

  end

  def self.down
    ActiveRecord::Base.connection.insert("replace into grade_levels (id, level) values (7, 7)")
  end
end
