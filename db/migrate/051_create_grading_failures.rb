class CreateGradingFailures < ActiveRecord::Migration
  def self.up
    create_table :grading_failures do |t|
      t.column :grader_id, :int
      t.column :report_id, :int
    end

    # add indeces on grader_id and report_id:
    add_index :grading_failures, :report_id
    add_index :grading_failures, :grader_id

  end

  def self.down
    drop_table :grading_failures
  end
end
