class CreateConfirmationBooleanForUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :confirmed, :boolean, :nullable => false, :default => false

    # update data:
    ActiveRecord::Base.connection.update("update users set confirmed = true")
  end

  def self.down
    remove_column :users, :confirmed
  end
end
