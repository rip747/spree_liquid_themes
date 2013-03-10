class BootstrapPagesMenu < Liquid::Tag
  def initialize(tag_name, block, tokens)
    super
    @name = block
  end

  def render(context)
    Refinery::Pages::MenuPresenter.new(context.registers[:action_view].refinery_menu_pages, context.registers[:action_view]).to_html
  end
end

Liquid::Template.register_tag('bootstrap_pages_menu', BootstrapPagesMenu)

########################################################################################################################

class RefineryPagesMenu < Liquid::Tag
  def initialize(tag_name, block, tokens)
    super
    @name = block
  end

  def render(context)
    if context['capture_variable']
      context[context['capture_variable']] ||= context.registers[:action_view].refinery_menu_pages.roots.inject([]) { |ary, menu_item| ary << Refinery::MenuItemDrop.new(menu_item); ary }
    else
      context['pages_roots'] ||= context.registers[:action_view].refinery_menu_pages.roots.inject([]) { |ary, menu_item| ary << Refinery::MenuItemDrop.new(menu_item); ary }
    end

    ''
  end
end

Liquid::Template.register_tag('refinery_pages_menu', RefineryPagesMenu)
