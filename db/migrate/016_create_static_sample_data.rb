# this will be the first migration to include data.  all database migrations from 
# now on will
#   a.  properly migrate all data
#   b.  use SQL instead of the models themselves for creating test data.
#     (see http://spin.atomicobject.com/2007/02/27/migration-testing-in-rails/)
# data migration from now on

class CreateStaticSampleData < ActiveRecord::Migration
  def self.up

    #books:
    ActiveRecord::Base.connection.insert("replace into books (id, title, author) values
( 1,  'The Grapes of Wrath', 'John Steinback')")

    # administrators:
    ActiveRecord::Base.connection.insert("replace into users  (id, login, email, crypted_password, salt, created_at,
   type) values
( 1,  'charles.finkel@barrelny.com', 'charles.finkel@barrelny.com',
'595d958b2a9219f210f86abc838847c761954202', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
'2007-09-20 16:34:05.0', 'Administrator')
      ,( 2,  'peter.kang@barrelny.com', 'peter.kang@barrelny.com',
'595d958b2a9219f210f86abc838847c761954202', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
'2007-09-20 16:34:05.0', 'Administrator')
      ,( 3,  'sei-wook.kim@barrelny.com', 'sei-wook.kim@barrelny.com',
'595d958b2a9219f210f86abc838847c761954202', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
'2007-09-20 16:34:05.0', 'Administrator')")

    #test student:
    ActiveRecord::Base.connection.insert("replace into users  (id, login, email, crypted_password, salt, created_at,
   type, first_name, last_name, grade_level) values
( 4,  'charles.finkel@gmail.com', 'charles.finkel@gmail.com',
'595d958b2a9219f210f86abc838847c761954202', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
'2007-09-20 16:34:05.0', 'Student', 'Bobby', 'Lee', 4 )")

    #test grader:
    ActiveRecord::Base.connection.insert("replace into users  (id, login, email, crypted_password, salt, created_at,
   type, first_name, last_name) values
( 5,  'cmanfu@cmanfu.com', 'cmanfu@cmanfu.com',
'595d958b2a9219f210f86abc838847c761954202', '36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8',
'2007-09-20 16:34:05.0', 'Grader','Mike', 'Jones')")

    #test report:
#    ActiveRecord::Base.connection.insert("replace into reports (id, book_id, student_id, grader_id) values
#( 1, 1, 4, 5)")

    # now get that report and add a report file:
    # nah, abort this due to conflicts with attachment_fu (really need to not be calling class methods in here, damn)
#    report = Report.find(1)
#    report.report_file = File.new("#{RAILS_ROOT}/test/fixtures/Grapes_of_Wrath_by_Bobby.doc").read
#    report.save

    #        id: 5
    #    type: Administrator
    #    login: charles
    #    email: charles.finkel@gmail.com
    #    salt: 36dbed72e2d3d096eb431cf9ee1f4fc46c6132f8
    #    crypted_password: 595d958b2a9219f210f86abc838847c761954202 # barrel
    #    created_at: <%= 1.days.ago.to_s :db %>



  end

  def self.down
    ActiveRecord::Base.connection.delete("delete from books where id in (1)")
    ActiveRecord::Base.connection.delete("delete from users where id in (1,2,3,4,5)")
    ActiveRecord::Base.connection.delete("delete from reports where id in (1)")

  end
end
