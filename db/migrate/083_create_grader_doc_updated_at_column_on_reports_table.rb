class CreateGraderDocUpdatedAtColumnOnReportsTable < ActiveRecord::Migration
  def self.up
    add_column :reports, :grader_doc_updated_at, :datetime
  end

  def self.down
    remove_column :reports, :grader_doc_updated_at
  end
end
