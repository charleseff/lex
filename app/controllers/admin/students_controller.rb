class Admin::StudentsController  < Admin::UsersController

  ssl_require_all

  layout "admin_scaffold"
  active_scaffold :student do |config|
    config.columns[:reports].form_ui = :select
    config.list.columns.exclude :remember_token, :remember_token_expires_at, :type, :salt, :crypted_password, :role, :first_name, :last_name
    config.list.columns << :name
    config.list.columns << :login_as_this_student

    
    config.create.columns.exclude :salt, :remember_token, :remember_token_expires_at, :type, :crypted_password
    config.create.columns << :password
    config.create.columns << :password_confirmation
    
    config.update.columns.exclude :crypted_password, :remember_token, :remember_token_expires_at, :salt, :type
    
    config.show.columns.exclude  :crypted_password, :remember_token, :remember_token_expires_at, :salt, :type, :role
  end

  private
  def allowed_users
    Set.new  [Administrator]
  end

end
