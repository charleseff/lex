class MoveReportFileDataToSeparateTable < ActiveRecord::Migration
  def self.up
# first create new submitted docs table:
    create_table :docs, :force => true do |t|
      t.column   :content_type, :string
      t.column   :filename, :string
      t.column   :thumbnail, :string
      t.column   :size, :integer
      t.column   :parent_id, :integer
      t.column   :width, :integer
      t.column   :height, :integer
      t.column :type, :string
    end

    remove_column :reports, :content_type
    remove_column :reports, :filename
    remove_column :reports, :thumbnail
    remove_column :reports, :size
    remove_column :reports, :parent_id
    remove_column :reports, :width
    remove_column :reports, :height

    remove_column :reports, :submitted_doc
    remove_column :reports, :graded_pdf
#    add_column :reports, :submitted_doc_id, :integer
#    add_column :reports, :graded_pdf_id, :integer

    # do i have to reverse the relationship?
    add_column :docs, :report_id, :integer

  end

  def self.down
    add_column :reports, :content_type, :string
    add_column :reports, :filename, :string
    add_column :reports, :thumbnail, :string
    add_column :reports, :size, :integer
    add_column :reports, :parent_id, :integer
    add_column :reports, :width, :integer
    add_column :reports, :height, :integer
    drop_table :docs

    add_column :reports, :submitted_doc, :binary
    add_column :reports, :graded_pdf, :binary
 #   remove_column :reports, :submitted_doc_id
 #   remove_column :reports, :graded_pdf_id


  end
end