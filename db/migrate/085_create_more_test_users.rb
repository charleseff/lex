class CreateMoreTestUsers < ActiveRecord::Migration
  def self.up
    #test student:
    # passwords: getgoing
    ActiveRecord::Base.connection.insert("replace into users  (id,  email, crypted_password, salt, created_at,
   type, first_name, last_name, confirmed,time_zone, sample,birth_date, grade_level_id) values
( 6,  'student@example.com', 
'6536d1dc77acb755072f215240c6a85f5d41ca30', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
'2007-09-20 16:34:05.0', 'Student', 'Bobby', 'Lee', true , 'Seoul', false, '1990-01-01 16:34:05.0', 4)")

    #test grader:
    ActiveRecord::Base.connection.insert("replace into users  (id,  email, crypted_password, salt, created_at,
   type, first_name, last_name, confirmed, time_zone, sample ) values
( 7,  'grader@example.com',
'6536d1dc77acb755072f215240c6a85f5d41ca30', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
'2007-09-20 16:34:05.0', 'Grader','Mike', 'Jones', true, 'Eastern Time (US & Canada)', false)")

  end

  def self.down
  end
end
