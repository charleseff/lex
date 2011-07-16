class Admin::BooksController < AuthorizationController
  ssl_require_all
  layout "admin_scaffold"
  active_scaffold :book

  private
  def allowed_users
    Set.new [Administrator]
  end

end
