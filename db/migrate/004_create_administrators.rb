class CreateAdministrators < ActiveRecord::Migration
  def self.up
    create_table :administrators do |t|
      t.column :name, :string
      t.column :password_hash, :string
      t.column :salt, :string
    end
  end

  def self.down
    drop_table :administrators
  end
end
