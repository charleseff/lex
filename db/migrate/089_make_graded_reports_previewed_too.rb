class MakeGradedReportsPreviewedToo < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.update("
update reports set submitted_for_preview = true where graded_at is not null ")
  end

  def self.down
    ActiveRecord::Base.connection.update("
update reports set submitted_for_preview = false where graded_at is not null ")
  end
end
