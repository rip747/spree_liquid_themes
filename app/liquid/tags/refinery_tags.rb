class BootstrapPagesMenu < Clot::ClotTag
  def initialize(tag_name, block, tokens)
    super
    @name = block
  end

  def render(context)
    context.registers[:controller].render :partial => "refinery/shared/pages_menu"
  end
end

Liquid::Template.register_tag('bootstrap_pages_menu', BootstrapPagesMenu)

########################################################################################################################

class RefineryPagesMenu < Clot::ClotTag
  def initialize(tag_name, block, tokens)
    super
    @name = block
  end

  def render(context)
    context['pages_roots'] = context.registers[:action_view].refinery_menu_pages.roots
    ''
  end
end

Liquid::Template.register_tag('refinery_pages_menu', RefineryPagesMenu)
