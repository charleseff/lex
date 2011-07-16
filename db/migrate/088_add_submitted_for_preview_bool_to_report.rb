class AddSubmittedForPreviewBoolToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :submitted_for_preview, :boolean, :default => false

    # set it to false for all previous reports:
    ActiveRecord::Base.connection.update("
update reports set submitted_for_preview = false")
  end

  def self.down
    remove_column :reports, :submitted_for_preview
  end
end
