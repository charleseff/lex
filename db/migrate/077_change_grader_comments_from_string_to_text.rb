class ChangeGraderCommentsFromStringToText < ActiveRecord::Migration
  def self.up
    change_column :reports, :grader_comment, :text
  end

  def self.down
    change_column :reports, :grader_comment, :string
  end
end
