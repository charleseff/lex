class AdjustUserTypes < ActiveRecord::Migration
  def self.up
    drop_table :people
    
    create_table :students do |t|
      t.column :grade_level,  :integer, :limit => 10, :precision => 10, :scale => 0
    end
    create_table :administrators do |t|
    end
    create_table :graders do |t|
    end
    
  end

  def self.down
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

    drop_table :students
    drop_table :graders
    drop_table :administrators
  end
end
