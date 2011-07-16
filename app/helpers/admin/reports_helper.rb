module Admin::ReportsHelper

  def submitted_document_column(report)
    link_to('submitted doc', :controller => '/admin/reports', :id => report.id, :action => :download_submitted_doc)
  end

  def graded_pdf_column(report)
    if report.has_pdf
      link_to('graded pdf', :controller => '/admin/reports', :id => report.id, :action => :download_graded_pdf)
    else
      'n/a'
    end
  end

  def graded_report_page_column(report)
    if report.graded?
      link_to("report page", :controller => '/admin/reports', :action => :show_report, :id => report.id)
    else
      'n/a'
    end
  end

end