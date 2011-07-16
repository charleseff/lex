class MoveNamesToStudentAndGrader < ActiveRecord::Migration
  # also get rid of the dummy column which is now unnecessary
  def self.up
    remove_column :users, :first_name
    remove_column :users, :last_name
    add_column :graders, :first_name, :string
    add_column :graders, :last_name, :string
    add_column :students, :first_name, :string
    add_column :students, :last_name, :string
    remove_column :graders, :dummy_column
  end

  def self.down
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    remove_column :graders, :first_name
    remove_column :graders, :last_name
    remove_column :students, :first_name
    remove_column :students, :last_name
    add_column :graders, :dummy_column, :string
  end
end
