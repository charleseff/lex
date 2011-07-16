class CreatePeopleTable < ActiveRecord::Migration
  def self.up
    drop_table :students
    drop_table :graders
    drop_table :administrators
    
    create_table "people", :force => true do |t|
      t.column :type, :string
      
      # common attributes
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :email, :string, :null => false
      t.column :password_hash, :string, :null => false
      t.column :salt, :string, :null => false

      # attributes for students:
      t.column :grade_level,  :integer, :limit => 10, :precision => 10, :scale => 0
    end

  end

  def self.down
    create_table "administrators", :force => true do |t|
      t.column "name",          :string
      t.column "password_hash", :string
      t.column "salt",          :string
    end

    create_table "graders", :force => true do |t|
      t.column "first_name",    :string, :default => "", :null => false
      t.column "last_name",     :string, :default => "", :null => false
      t.column "password_hash", :string, :default => "", :null => false
      t.column "email_address", :string, :default => "", :null => false
    end

    create_table "students", :force => true do |t|
      t.column "first_name",    :string,                                               :default => "", :null => false
      t.column "last_name",     :string,                                               :default => "", :null => false
      t.column "grade_level",   :integer, :limit => 10, :precision => 10, :scale => 0,                 :null => false
      t.column "password_hash", :string
      t.column "email_address", :string,                                               :default => "", :null => false
      t.column "salt",          :string,                                               :default => "", :null => false
    end

  end
end
