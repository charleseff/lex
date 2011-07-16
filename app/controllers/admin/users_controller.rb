class Admin::UsersController  < AuthorizationController

  def login_as_user
    self.current_user = User.find_by_id(params[:id])
    redirect_to root_path
  end
end
