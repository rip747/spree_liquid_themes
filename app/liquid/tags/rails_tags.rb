# {% cache "some_key" %}
#   ...
# {% endcache %}

class Cacher < Liquid::Tag
  def initialize(tag_name, markup, tokens)
    super
    @key= markup.to_s
  end

  def render(context)
    Rails.cache.fetch(@key) do
      super
    end
  end
end

Liquid::Template.register_tag('cache', Cacher)

########################################################################################################################

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

class TagBuilder < Liquid::Tag
  QuotedString                = /"[^"]*"|'[^']*'/
  QuotedFragment              = /#{QuotedString}|(?:[^\s,\|'"]|#{QuotedString})+/o
  TagAttributes               = /(\w+)\s*\:\s*(#{QuotedFragment})/o

  def initialize(tag_name, markup, tokens)
    unless markup.empty?
      @attributes = {}
      markup.scan(Liquid::TagAttributes) do |key, value|
        @attributes[key] = value
      end
    end
    super
  end

  def render(context)
    context['form'].send(@attributes['tag'].to_sym, @attributes.except('tag'))
  end
end

Liquid::Template.register_tag('tag_builder', TagBuilder)
