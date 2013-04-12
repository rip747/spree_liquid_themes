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
    @result = context.registers[:action_view].image_tag(@url)
    super(context)
  end
end

Liquid::Template.register_tag('image_tag', ImageTag)

#######################################################################################################################
class Flash < Liquid::Tag
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
    @result = context.registers[:action_view].controller.flash.to_hash.stringify_keys[@attributes['key']]
    super(context)
  end
end

Liquid::Template.register_tag('flash', Flash)
#######################################################################################################################

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
    if @attributes.has_key?('html')
      @attributes['html'] = eval(@attributes['html'].chomp('"').reverse.chomp('"').reverse)
    end
    @result = context['form'].send(@attributes['tag'].to_sym, @attributes.except('tag'))
    super(context)
  end
end

Liquid::Template.register_tag('tag_builder', TagBuilder)

########################################################################################################################

class Paginator < Liquid::Tag

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
    context.registers[:action_view].will_paginate(context[@attributes['collection']])
  end
end

Liquid::Template.register_tag('paginator', Paginator)

#########################################################################################################################

class UrlHelper < Liquid::Tag
  QuotedString                = /"[^"]*"|'[^']*'/
  QuotedFragment              = /#{QuotedString}|(?:[^\s,\|'"]|#{QuotedString})+/o
  TagAttributes               = /(\w+)\s*\:\s*(#{QuotedFragment})/o

  include Clot::TagHelper

  def initialize(tag_name, markup, tokens)
    unless markup.empty?
      @attributes = []
      markup.scan(Liquid::QuotedFragment) do |value|
        @attributes << value
      end
    end
    super
  end

  def render(context)
    return '' if @attributes.empty?

    @url_helper ||= @attributes.shift.to_sym
    args = []
    @attributes.each_with_index do |value, index|
      args[index] = resolve_value(value, context)
    end

    # TODO refactoring
    if Refinery::Core::Engine.routes.url_helpers.respond_to? @url_helper
    path = Refinery::Core::Engine.routes.url_helpers.send(@url_helper, *args)
    elsif Spree::Core::Engine.routes.url_helpers.respond_to? @url_helper
      path = Spree::Core::Engine.routes.url_helpers.send(@url_helper, *args)
    elsif Rails.application.routes.url_helpers.respond_to? @url_helper
      path = Rails.application.routes.url_helpers.send(@url_helper, *args)
    else
      path = 'not found'
    end

    path
  end
end

Liquid::Template.register_tag('url_helper', UrlHelper)

#############################################################################################################################################################################################################################################
