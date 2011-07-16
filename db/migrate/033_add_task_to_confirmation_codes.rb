class AddTaskToConfirmationCodes < ActiveRecord::Migration
  def self.up
    add_column :confirmation_codes, :task, :string
  end

  def self.down
    remove_column :confirmation_codes, :task
  end
end
