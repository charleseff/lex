class AddColumnsToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :content_type, :string
    add_column :reports, :filename, :string
    add_column :reports, :thumbnail, :string
    add_column :reports, :size, :integer
  end

  def self.down
    remove_column :reports, :content_type
    remove_column :reports, :filename
    remove_column :reports, :thumbnail
    remove_column :reports, :size
  end
end
