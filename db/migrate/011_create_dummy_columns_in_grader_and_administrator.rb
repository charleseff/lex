# this is so ActiveScaffold knows what to do (it expects at least one column in the table otherwise
# it gets a SQL exception
class CreateDummyColumnsInGraderAndAdministrator < ActiveRecord::Migration
  def self.up
    add_column :graders, :dummy_column, :string
    add_column :administrators, :dummy_column, :string
  end

  def self.down
    remove_column :graders, :dummy_column
    remove_column :administrators, :dummy_column
  end
end
