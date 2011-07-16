class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.column :title, :string
      t.column :author, :string
    end
    # since this is pre-production, i dont have to migrate the book titles over yet:
    remove_column :reports, :book_title
    add_column :reports, :book_id, :integer
  end

  def self.down
    drop_table :books
    remove_column :reports, :book_id
    add_column :reports, :book_title, :string
  end
end
