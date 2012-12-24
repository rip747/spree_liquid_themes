ActionView::TemplateRenderer.class_eval do
=begin
  def render_with_layout(path, locals) #:nodoc:
    layout  = path && find_layout(path, locals.keys)
    content = yield(layout)

    if layout
      @view.view_flow.set(:layout, content)
      if layout.virtual_path.to_s.eql?("layouts/refinery/admin")
        layout.render(@view, locals){ |*name| @view._layout_for(*name) }
      else
        liquid_render layout.render(@view, locals){ |*name| @view._layout_for(*name) }
      end
    else
      content
    end
  end

  def liquid_render(html)
    @template = Liquid::Template.parse(html)
    @template.render(@assigns).html_safe
  end
=end

end