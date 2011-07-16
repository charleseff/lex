module ResourceCenter::ResourceCenterModule

  def get_layout
    if action_name == 'sample_report'
      'sample'
    else
      'main'
    end
  end

  def set_section
    @section = 'resource_center'
  end

end
