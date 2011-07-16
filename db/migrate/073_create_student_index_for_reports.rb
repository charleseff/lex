class CreateStudentIndexForReports < ActiveRecord::Migration
  def self.up
    add_index :reports, :student_id
  end

  def self.down
    remove_index :reports, :student_id
  end
end
