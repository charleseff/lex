# back to single table inheritance (sigh, this seemst to be the best solution for now)
class BackToSti < ActiveRecord::Migration
  def self.up
    drop_table :students
    drop_table :graders
    drop_table :administrators
    
    add_column :users, :grade_level,  :integer
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    
    remove_column :users, :role_id
    remove_column :users, :role_type
    add_column :users, :type, :string

    
    # do  something with this connection object:
    #    ActiveRecord::Base.connection
  end

  def self.down
    create_table "students", :force => true do |t|
      t.column "grade_level", :integer, :limit => 10
      t.column "first_name",  :string
      t.column "last_name",   :string
    end
    create_table "administrators", :force => true do |t|
      t.column "dummy_column", :string
    end

    create_table "graders", :force => true do |t|
      t.column "first_name", :string
      t.column "last_name",  :string
    end

    remove_column :users, :grade_level
    remove_column :users, :first_name
    remove_column :users, :last_name

    add_column :users, :role_id, :integer
    add_column :users, :role_type, :string
    remove_column :users, :type


  end
end
