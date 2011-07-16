class ResourceCenter::GraderController < AuthorizationController
  ssl_require_all
  include ResourceCenter::ResourceCenterModule

  caches_action :index
  layout :get_layout

  def resource
    render :template => "resource_center/grader_resources/#{params[:id]}"
  end
 
  def sample_report
    @report = sample_report_from_id_only_if_user_has_rights(params[:id])
    redirect_to root_path unless @report
  end

  def sample_report_pdf
    filename= "#{params[:id]}.pdf"
    send_data File.open("#{RAILS_ROOT}/app/views/resource_center/grader_resources/#{filename}",'r').read , :filename =>filename,  :type => "application/pdf"
  end

  private
  def allowed_users
    Set.new  [Grader]
  end

end
