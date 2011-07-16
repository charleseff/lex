class AddCreatedAtTimeForConfirmationCodes < ActiveRecord::Migration
  def self.up
    add_column :confirmation_codes, :created_at, :datetime
      end

  def self.down
    remove_column  :confirmation_codes, :created_at
  end
end
