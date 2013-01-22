class ImageTag < Liquid::Tag

  def initialize(tag_name, markup, tokens)
    unless markup.empty?
      if markup =~ /url:([*.]+)/
        @url = $1
      end
    end
    super
  end

  def render(context)
    context.registers[:action_view].image_tag(@url)
  end
end

Liquid::Template.register_tag('image_tag', ImageTag)
