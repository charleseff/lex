class RemoveActiveColumnFromReport < ActiveRecord::Migration
  def self.up
    remove_column  :reports, :active
  end

  def self.down
    add_column :reports, :active, :boolean
  end
end
