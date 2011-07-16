class CreatePdfs < ActiveRecord::Migration
  def self.up
    create_table :pdfs do |t|
      t.column :filename, :string
      t.column :report_id, :int
    end
  end

  def self.down
    drop_table :pdfs
  end
end
