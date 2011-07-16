class GraderWasWarnedBoolean < ActiveRecord::Migration
  def self.up
    add_column :reports, :grader_was_warned, :boolean, :default => false
  end

  def self.down
    remove_column :reports, :grader_was_warned
  end
end
