class CreateSampleUserColumn < ActiveRecord::Migration
  def self.up
    add_column :users, :sample, :boolean, :default => false
    ActiveRecord::Base.connection.update("update users set sample = false")

  end

  def self.down
    remove_column :users, :sample
  end
end