class FormAuthenticityTokenMenu < Liquid::Tag
  def initialize(tag_name, block, tokens)
    super
    @name = block
  end

  def render(context)
    context.registers[:controller].form_authenticity_token.inspect
  end
end

Liquid::Template.register_tag('form_authenticity_token', FormAuthenticityTokenMenu)
