class RemoveGradedSubmissions < ActiveRecord::Migration
  def self.up
    # drop table, even tho i want this concept later, eitehr in the DB or object-level:
    drop_table :grader_submissions
  end

  def self.down
    create_table :grader_submissions do |t|
      t.column :report_id, :int
      t.column :comment, :string
    end
  end
end
