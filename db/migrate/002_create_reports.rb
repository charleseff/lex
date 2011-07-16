class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
        t.column :student_id, :integer, :null => false
        t.column :book_title, :string, :null => false
        t.column :report_file, :binary, :null => false
        t.column :grader_id, :integer
    end
  end

  def self.down
    drop_table :reports
  end
end
