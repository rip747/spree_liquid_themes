class PagesMenu < Liquid::Tag
  def initialize(tag_name, block, tokens)
    super
    @name = block
  end

  def render(context)
    context.registers[:controller].render :partial => "refinery/shared/pages_menu"
  end
end

Liquid::Template.register_tag('pages_menu', PagesMenu)