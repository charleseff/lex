class AddNamesToAdmins < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.update("
update users set first_name = 'Charles', last_name = 'Finkel' where email = 'charles.finkel@barrelny.com' ")
    ActiveRecord::Base.connection.update("
update users set first_name = 'Sei-Wook', last_name = 'Kim' where email = 'sei-wook.kim@barrelny.com' ")
    ActiveRecord::Base.connection.update("
update users set first_name = 'Peter', last_name = 'Kang' where email = 'peter.kang@barrelny.com' ")

  end

  def self.down
  end
end
