module Admin::GradersHelper

  def login_as_this_grader_column(student)
     link_to('login (** you must relogin as admin afterwards)', :controller => '/admin/graders', :id => student.id, :action => :login_as_user)
  end
  
end