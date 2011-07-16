# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(title)
    @page_title = title
  end


  # from Dan Webb's MinusMOR plugin
  def js(data)
    if data.respond_to? :to_json
      data.to_json
    else
      data.inspect.to_json
    end
  end


  # from Dan Webb's MinusMOR plugin
  # enhanced with ability to detect partials with template format, i.e.: _post.html.erb
  def partial(name, options={})
    old_format = self.template_format
    self.template_format = :html
    js render({ :partial => name }.merge(options))
  ensure
    self.template_format = old_format
  end

  # from Dan Webb's MinusMOR plugin
  # enhanced with ability to detect partials with template format, i.e.: _post.html.erb
  def partial_javascript(name, options={})
    old_format = self.template_format
    self.template_format = :js
    render({ :partial => name }.merge(options))
  ensure
    self.template_format = old_format
  end

end
