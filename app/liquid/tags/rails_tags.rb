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

########################################################################################################################

# Example usage: {% url_helper method:'product' type:'path' obj:'product' %}
class UrlHelper < Liquid::Tag

  def initialize(tag_name, markup, tokens)
    unless markup.empty?
      if markup =~ /method:([_a-z0-9]+)/
        @method = $1
      end

      if markup =~ /obj:([_a-z0-9]+)/
        @obj = $1
      end

      if markup =~ /type:url.*/
        @type = 'url'
      end

      if markup =~ /type:path.*/
        @type = 'path'
      end
    end

    super
  end

  def render(context)
    return "you must specify 'path' and 'type' params for url_helper tag"  if @method.nil? and @type.nil?
    view = context.registers[:action_view]
    method = "#{@method}_#{@type}".to_sym
    arg = context[@obj].source if @obj

    url = view.send(method, arg) if view.respond_to?(method)
    url = view.spree.send(method, arg) if view.spree.routes.routes.named_routes.include?(@method)
    url = view.refinery.send(method, arg) if view.refinery.routes.routes.named_routes.include?(@method)
    url = "route #{method} not found"  if url.nil?

    url
  end
end

Liquid::Template.register_tag('url_helper', UrlHelper)
