class AddAgeToStudent < ActiveRecord::Migration
  def self.up
    add_column :users, :birth_date, :date

    # update all to 1990:
    ActiveRecord::Base.connection.update("update users set birth_date =
'1990-01-01 16:34:05.0' where type='Student'")
  end

  def self.down
    remove_column :users, :birth_date
  end
end
