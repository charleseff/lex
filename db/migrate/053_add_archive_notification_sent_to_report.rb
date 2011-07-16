class AddArchiveNotificationSentToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :archive_notification_sent, :boolean, :default => false
  end

  def self.down
    remove_column :reports, :archive_notification_sent
  end
end
