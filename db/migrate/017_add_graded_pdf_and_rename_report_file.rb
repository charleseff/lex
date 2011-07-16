class AddGradedPdfAndRenameReportFile < ActiveRecord::Migration
  def self.up
    add_column :reports, :submitted_doc, :binary,  :default => ""
    remove_column :reports, :report_file
    add_column :reports, :graded_pdf, :binary,  :default => ""
  end

  def self.down
    add_column :reports, :report_file, :binary,  :default => ""
    ActiveRecord::Base.connection.update("update reports set report_file = submitted_doc")
    remove_column :reports, :submitted_doc

    remove_column :reports, :graded_pdf
  end
end
