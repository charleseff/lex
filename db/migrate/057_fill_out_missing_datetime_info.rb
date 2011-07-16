class FillOutMissingDatetimeInfo < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.update("update reports set created_at = curdate()")
    ActiveRecord::Base.connection.update("update reports set updated_at = curdate()")

  end

  def self.down
  end
end
