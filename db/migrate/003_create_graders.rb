class CreateGraders < ActiveRecord::Migration
  def self.up
    create_table :graders do |t|
      t.column :first_name, :string, :null => false
      t.column :last_name, :string, :null => false
      t.column :password_hash, :string, :null => false
      t.column :email_address, :string, :null => false
    end
  end

  def self.down
    drop_table :graders
  end
end
