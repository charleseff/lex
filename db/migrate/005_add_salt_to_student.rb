class AddSaltToStudent < ActiveRecord::Migration
  def self.up
    #      t.column :salt, :string, :null => false
    add_column :students, :salt, :string, :null => false

  end

  def self.down
    remove_column :students, :salt
  end
end
