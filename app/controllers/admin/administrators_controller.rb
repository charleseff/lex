require 'set'
class Admin::AdministratorsController < AuthorizationController
  ssl_require_all
  layout "admin_scaffold"

  active_scaffold :administrator do |config|
    config.list.columns.exclude :grade_level, :remember_token, :remember_token_expires_at, :type, :salt,
            :crypted_password, :role, :first_name, :last_name, :birth_date
    config.list.columns << :name

    config.create.columns.exclude :grade_level, :salt, :remember_token, :remember_token_expires_at, :type,
            :crypted_password, :birth_date
    config.create.columns << :password
    config.create.columns << :password_confirmation

    config.update.columns.exclude :grade_level, :crypted_password, :remember_token, :remember_token_expires_at,
            :salt, :type, :birth_date

    config.show.columns.exclude :grade_level, :crypted_password, :remember_token, :remember_token_expires_at,
            :salt, :type, :role, :birth_date
  end

  private
  def allowed_users
    Set.new  [Administrator]
  end

end