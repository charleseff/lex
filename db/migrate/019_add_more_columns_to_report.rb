class AddMoreColumnsToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :parent_id, :integer
    add_column :reports, :width, :integer
    add_column :reports, :height, :integer
  end

  def self.down
    remove_column :reports, :parent_id
    remove_column :reports, :width
    remove_column :reports, :height
  end
end
