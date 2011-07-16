# just have this do nothing:
class AddTestData2 < ActiveRecord::Migration
  def self.up
    # password is 'barrel'
    
#    Student.create(:first_name => 'Student',      :last_name => 'Dude',
#      :grade_level => 4,
#     
#      :salt => 'XlDp3KMS',:password_hash => 'faaef3cf121ecf369af63e2ef6acff8c2667d551376f2953689737d090df2b5c')
#    Grader.create(:first_name => 'Grader', :last_name => 'Chick',
#      :email => 'grader@foo.com',
#      :salt => 'XlDp3KMS',:password_hash => 'faaef3cf121ecf369af63e2ef6acff8c2667d551376f2953689737d090df2b5c')
#    Administrator.create(:first_name => 'Charles', :last_name => 'Finkel', :email => 'administrator@foo.com',
#      :salt => 'GNARhFG/', :password_hash => 'f7636ea59c8d0467a14fb9d3cc1c68f36063c232b6f84e09290d580d2995017a')
  end

  def self.down
#    People.delete_all
  end
end
