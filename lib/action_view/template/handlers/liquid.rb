# origianl: https://gist.github.com/4605222
# variants:
# https://gist.github.com/4605162
#
class ActionView::Template::Handlers::Liquid

  PROTECTED_ASSIGNS = %w( _routes template_root response _session template_class action_name request_origin session template
                          _response url _request _cookies variables_added _flash params _headers request cookies
                          ignore_missing_templates flash _params logger before_filter_chain_aborted headers )


  def self.call(template)
    "ActionView::Template::Handlers::Liquid.new(self).render(#{template.source.inspect}, local_assigns)"
  end

  def initialize(view)
    @view = view
  end

  def render(template, local_assigns = {})
    @view.controller.headers["Content-Type"] ||= 'text/html; charset=utf-8'

    assigns = @view.assigns.update('view' => @view)
    assigns['site_name'] = Refinery::Core.site_name
    assigns['theme_assigns'] = Refinery::Themes::Theme.current_theme_config['assigns']
    assigns['theme_config'] = Refinery::Themes::Theme.current_theme_config['config']
    assigns['spree_config'] = Spree::Config

    #TODO
    #assigns = (@view.instance_variables.map{ |i| i.to_s} - PROTECTED_INSTANCE_VARIABLES).inject({}) do |hash, var_name|
    #  hash[var_name.to_s.sub('@', '')] = @view.instance_eval(var_name.to_s)
    #  #hash[var_name[1..-1]] = @view.instance_variable_get(var_name)
    #  hash
    #end

    assigns.merge!(local_assigns.stringify_keys)

    @view.controller._helpers.instance_methods.each do |method|
      assigns[method.to_s] = Proc.new { @view.send(method) }
    end

    controller = @view.controller

    filters = if controller.respond_to?(:liquid_filters, true)
                controller.send(:liquid_filters)
              elsif controller.respond_to?(:master_helper_module)
                [controller.master_helper_module]
              else
                [controller._helpers]
              end

    # TODO content_for from layout to partial
    #unless assigns[:layout_prerender]
    #  @layout = Liquid::Template.parse(Refinery::Themes::Theme.layout_raw(assigns['page'].layout_template))
    #  @layout.render(assigns, :registers => {:filters => filters, :action_view => @view, :controller => @view.controller})
    #  assigns[:layout_prerender] = true
    #end

    @view.view_flow.content.each do  |key, content|
      assigns["content_for_#{key.to_s}"] = content
    end

    partials_path = Liquid::LocalFileSystem.new(Refinery::Themes::Theme.theme_path.join("views/partials"))

    assigns['page'].parts.each do |part|
      Liquid::Template.parse(part.body).render(assigns)
      assigns["content_for_#{part.title}"] =
          Liquid::Template.parse(part.body).render(assigns,
                                                   :filters => filters,
                                                   :registers => {
                                                       :file_system => partials_path,
                                                       :action_view => @view,
                                                       :controller => @view.controller
                                                   }).html_safe
    end if assigns['page']

    variables = assigns.reject{ |k,v| PROTECTED_ASSIGNS.include?(k) }

    liquid = Liquid::Template.parse(CGI::unescape(template))
    liquid.render(variables, :filters => filters, :registers => {:file_system => partials_path, :action_view => @view, :controller => @view.controller})
  end

  def compilable?
    false
  end
end

