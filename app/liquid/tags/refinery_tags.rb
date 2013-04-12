class BootstrapPagesMenu < Liquid::Tag
  def initialize(tag_name, block, tokens)
    super
    @name = block
  end

  def render(context)
    @result = Refinery::Pages::MenuPresenter.new(context.registers[:action_view].refinery_menu_pages, context.registers[:action_view]).to_html
    super(context)
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
    @result ||= context.registers[:action_view].refinery_menu_pages.roots.inject([]) { |ary, menu_item| ary << Refinery::MenuItemDrop.new(menu_item); ary }
    context['pages_roots'] ||= context.registers[:action_view].refinery_menu_pages.roots.inject([]) { |ary, menu_item| ary << Refinery::MenuItemDrop.new(menu_item); ary }
    super(context)
  end
end

Liquid::Template.register_tag('refinery_pages_menu', RefineryPagesMenu)

########################################################################################################################

class BlogTagCloud < Liquid::Tag
  def initialize(tag_name, block, tokens)
    super
    @name = block
  end

  def render(context)
    template = context.registers[:action_view]
    @result = []
    template.tag_cloud(context['tags'], %w(tag1 tag2 tag3 tag4)) do |tag, css_class|
      @result << {'name' => tag.name, 'url' => template.refinery.blog_tagged_posts_path(tag.id, tag.name.parameterize),
                                                                                              'css_class' => css_class}
    end
     super(context)
  end
end

Liquid::Template.register_tag('blog_tag_cloud', BlogTagCloud)

########################################################################################################################

class BlogArchiveWidget < Liquid::Tag
  def render(context)
    template = context.registers[:action_view]
    @result = template.blog_archive_widget
    super(context)
  end
end

Liquid::Template.register_tag('blog_archive_widget', BlogArchiveWidget)

########################################################################################################################

class RecentBlogPosts < Liquid::Tag
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
    return unless !@attributes.empty? and @attributes.has_key? 'count'
    @result = Refinery::Blog::Post.recent(@attributes['count'])
    context['recent_posts'] = @result
    super(context)
  end
end

Liquid::Template.register_tag('recent_blog_posts', RecentBlogPosts)

########################################################################################################################