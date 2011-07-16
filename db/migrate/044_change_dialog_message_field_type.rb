class ChangeDialogMessageFieldType < ActiveRecord::Migration
  def self.up
    change_column :dialog_messages, :message, :text
  end

  def self.down
    change_column :dialog_messages, :message, :string
  end
end
