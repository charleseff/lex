class CreateTimeZonesForAdministrators < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.update("
update users set time_zone = 'Eastern Time (US & Canada)'
  where email in ('charles.finkel@barrelny.com', 'sei-wook.kim@barrelny.com', 'peter.kang@barrelny.com') ")
  end

  def self.down
    # not gonna undo
  end
end
