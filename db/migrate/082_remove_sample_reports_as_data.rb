class RemoveSampleReportsAsData < ActiveRecord::Migration
  def self.up
    # decided to make sample reports static html again..
    ActiveRecord::Base.connection.delete("delete from reports where id in (1,2)")
    ActiveRecord::Base.connection.delete("delete from graded_ptal_task_items where report_id in (1,2)")

    ActiveRecord::Base.connection.delete("delete from users where email like '%example.com'")
  end

  def self.down
     # not gonna reproduce:
  end
end
