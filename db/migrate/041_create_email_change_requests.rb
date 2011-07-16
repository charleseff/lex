class CreateEmailChangeRequests < ActiveRecord::Migration
  def self.up
    create_table :email_change_requests do |t|
      t.column :user_id, :int
      t.column :email, :string
      t.column :confirmation_code, :string
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :email_change_requests
  end
end
