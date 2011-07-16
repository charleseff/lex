module Admin::StudentsHelper

  def login_as_this_student_column(student)
     link_to('login (** you must relogin as admin afterwards)', :controller => '/admin/students', :id => student.id, :action => :login_as_user)
  end
  
end