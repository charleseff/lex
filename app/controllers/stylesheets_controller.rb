class StylesheetsController < ApplicationController

  %w(main_student main_grader main_administrator main).each do |css|
    eval "caches_page :#{css}"
    eval "def #{css}
            make_css
          end"
  end

  private
  def make_css
    respond_to do |format|
      format.css do
        render
      end
    end
  end

end
