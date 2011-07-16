class CreateDialogMessages < ActiveRecord::Migration
  def self.up
    create_table :dialog_messages do |t|
      t.column :report_id, :integer
      t.column :speaker, :string
      t.column :message, :string
    end
  end

  def self.down
    drop_table :dialog_messages
  end
end
