class AddSubmittedDateToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :submitted, :datetime
  end

  def self.down
    remove_column :reports, :submitted
  end
end
