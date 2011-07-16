class ChangeTimezoneData < ActiveRecord::Migration

  def self.up
    ActiveRecord::Base.connection.update("
update users set time_zone = 'Asia/Seoul'
  where time_zone = 'Seoul' ")
    ActiveRecord::Base.connection.update("
update users set time_zone = 'America/New_York'
  where time_zone = 'Eastern Time (US & Canada)' ")
  end

  def self.down
    ActiveRecord::Base.connection.update("
update users set time_zone = 'Seoul'
  where time_zone = 'Etc/GMT+9' ")
    ActiveRecord::Base.connection.update("
update users set time_zone = 'Eastern Time (US & Canada)'
  where time_zone = 'Etc/GMT-5' ")
  end

=begin

  def self.down
    ActiveRecord::Base.connection.update("
update users set time_zone = 'Seoul'
  where time_zone = 'Asia/Seoul' ")
    ActiveRecord::Base.connection.update("
update users set time_zone = 'Eastern Time (US & Canada)'
  where time_zone = 'America/New_York' ")
  end
=end


end
