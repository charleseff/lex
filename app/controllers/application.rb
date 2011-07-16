# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  class_inheritable_accessor :ssl_required_all  

  before_filter :login_from_cookie
  before_filter :create_user_type_alias
  # sets the section so that the top banner on the page can highlight it
  before_filter :set_section

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '1810c82aed9d5348beb914c71ffc94d3'

  # for notifying exceptions:
  include ExceptionNotifiable

  # for ssl_requirement:
  include SslRequirement

  # included for acts_as_authenticated:
  include AuthenticatedSystem

  def self.random_string(length)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    string = ""
    1.upto(length) { |i| string << chars[rand(chars.size-1)] }
    return string
  end

  def user_index
    if (not current_user.class == Symbol)
      "#{current_user.class.to_s.downcase}_index"
    end
  end

  private
  def create_user_type_alias
    return if current_user == nil
    if (current_user.is_a? Student)
      @student = current_user
    elsif (current_user.is_a? Grader)
      @grader = current_user
    elsif (current_user.is_a? Administrator)
      @administrator = current_user
    end
  end

  # default section:
  def set_section
    @section = 'home'
  end

  # renders the partial of the action in the location you're at
  def respond_to_ajax(partial_name=nil)

    partial = partial_name == nil ? action_name : partial_name

    respond_to do |format|
      format.html do
        render :inline => "<textarea><%= partial_javascript '#{partial}' %></textarea>"
      end
      format.js do
        render :partial => partial
      end
    end

  end

end
