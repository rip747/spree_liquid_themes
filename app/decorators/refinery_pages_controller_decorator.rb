Refinery::PagesController.class_eval do

  protected

  def render_with_templates?(render_options = {})
    if Refinery::Pages.use_layout_templates && page.layout_template.present?
      render_options[:layout] = page.layout_template
    end
    if Refinery::Pages.use_view_templates && page.view_template.present?
      render_options[:action] = page.view_template
    end
    render render_options if render_options.any?
  end



end