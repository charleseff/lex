class ResourceCenter::StudentController < AuthorizationController
  ssl_require_all
  include ResourceCenter::ResourceCenterModule
  layout :get_layout

  def resource
    @resource = current_user.grade_level.resources.find(params[:id])
    render :template => "/resource_center/resources/#{@resource.file_name}"
  end

  private
  def allowed_users
    Set.new  [Student]
  end
end
