class CreateConfirmationCodes < ActiveRecord::Migration
  def self.up
    create_table :confirmation_codes do |t|
      t.column :user_id, :integer
      t.column :code, :string
    end
  end

  def self.down
    drop_table :confirmation_codes
  end
end
