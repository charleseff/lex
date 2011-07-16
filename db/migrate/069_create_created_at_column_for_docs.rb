class CreateCreatedAtColumnForDocs < ActiveRecord::Migration
  def self.up
    add_column :docs, :created_at, :datetime
  end

  def self.down
    remove_column :docs, :created_at
  end
end
