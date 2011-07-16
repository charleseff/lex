class Admin::ReportsController  < AuthorizationController
  include ShowsReports
  layout :get_layout
  before_filter :get_report, :only => [ :download_submitted_doc, :download_graded_flash, :download_graded_pdf, :show_report ]
  ssl_require_all

  active_scaffold :report do |config|
#    config.columns[:student].form_ui = :select

    config.list.columns = [:student, :book, :assignment_topic, :created_at, :assigned_to_grader_at, :grader, :last_saved_by_grader_at,
        :graded_at, :grader_was_warned, :submitted_document, :graded_pdf, :graded?, :numerical_grade, :final_grade, :graded_report_page]
    config.columns[:student].set_link('nested', :parameters => {:associations => :student})
    config.columns[:grader].set_link('nested', :parameters => {:associations => :grader})
    config.columns[:book].set_link('nested', :parameters => {:associations => :book})
  end

  private
  def allowed_users
    Set.new  [Administrator]
  end

  def get_layout
    if request.path =~ /.*show_report.*/
      "main"
    else
      "admin_scaffold"
    end

  end
end