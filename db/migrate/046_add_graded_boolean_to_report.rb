class AddGradedBooleanToReport < ActiveRecord::Migration
  def self.up
    # needed because now we're allowing a pdf to be attached to a report before the report is finalized to be graded
    # (for previewing a report)
    add_column :reports, :graded, :boolean, :default => false
  end

  def self.down
    remove_column :reports, :graded
  end
end
