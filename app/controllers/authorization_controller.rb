class AuthorizationController < ApplicationController

  ssl_require_all
  before_filter :login_required

  # should return a set of user types allowed to access this area
  def allowed_users
    raise NotImplementedError.new("#{self.class.name}#allowed_users is an abstract method.")
  end

  def authorized?()
    # tests if the allowed_users set contains the class
    allowed_users.include? current_user.class
  end

  def access_denied
    respond_to do |accepts|
      accepts.html do
        if logged_in?
          redirect_to root_path
        else
          store_location
          redirect_to login_path
        end
      end
      accepts.xml do
        headers["Status"]           = "Unauthorized"
        headers["WWW-Authenticate"] = %(Basic realm="Web Password")
        render :text => "Could't authenticate you", :status => '401 Unauthorized'
      end
    end
    false
  end
  
end
  