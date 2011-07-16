class RenameUserEmails < ActiveRecord::Migration
  def self.up
    #test student:
    ActiveRecord::Base.connection.update("update users set email = 'test_lex_student@barrelny.com'
where email = 'charles.finkel@gmail.com' ")

    #test grader:
    ActiveRecord::Base.connection.update("update users set email = 'test_lex_grader@barrelny.com'
where email = 'cmanfu@cmanfu.com' ")

  end

  def self.down
    ActiveRecord::Base.connection.update("update users set email = 'charles.finkel@gmail.com'
where email = 'test_lex_student@barrelny.com' ")

    #test grader:
    ActiveRecord::Base.connection.update("update users set email =  'cmanfu@cmanfu.com' 
where email = 'test_lex_grader@barrelny.com' ")
  end
end
