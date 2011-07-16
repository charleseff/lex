class CreateGraderSubmissions < ActiveRecord::Migration
  def self.up
    create_table :grader_submissions do |t|
      t.column :report_id, :int
      t.column :comment, :string
    end
  end

  def self.down
    drop_table :grader_submissions
  end
end
