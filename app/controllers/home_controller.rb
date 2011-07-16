class HomeController < AuthorizationController

  ssl_require_all
  layout 'main'

  def index
    render :action => user_index
  end

  private

  def allowed_users
    Set.new  [Student, Administrator, Grader]
  end

  # todo: do me later
  def autocomplete_book_author
#    re = Regexp.new("^#{params[:user][:favorite_language]}" , "i" )
    #    @books= Book.find_all do |book|
    #      book.title.match re
    #    end
    #    render :layout=>false
  end


  def set_section
    @section = 'home'
  end

end
