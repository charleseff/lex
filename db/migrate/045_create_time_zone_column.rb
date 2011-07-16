class CreateTimeZoneColumn < ActiveRecord::Migration
  def self.up
    add_column :users, :time_zone, :string

    # set defaults:
    ActiveRecord::Base.connection.update("update users set time_zone =
'Seoul' where type='Student'")
    ActiveRecord::Base.connection.update("update users set time_zone =
'Eastern Time (US & Canada)' where type='Grader'")


  end

  def self.down
    remove_column :users, :time_zone
  end
end
