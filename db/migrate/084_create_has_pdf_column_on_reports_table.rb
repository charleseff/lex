class CreateHasPdfColumnOnReportsTable < ActiveRecord::Migration
  def self.up
    add_column :reports, :has_pdf, :boolean, :default => false

    
  end

  def self.down
    remove_column :reports, :has_pdf    
  end
end
