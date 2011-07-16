class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students, :force => true do |t|
      t.column :first_name, :string, :null => false
      t.column :last_name, :string, :null => false
      t.column :grade_level, :decimal, :null => false
      t.column :password_hash, :string
      #, :null => false
      t.column :email_address, :string, :null => false
    end
  end

  def self.down
    drop_table :students
  end
end
