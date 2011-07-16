class AddedGraderComment < ActiveRecord::Migration
  def self.up
    add_column :reports, :grader_comment, :string, :default => ''
  end

  def self.down
    remove_column :reports, :grader_comment
  end
end
