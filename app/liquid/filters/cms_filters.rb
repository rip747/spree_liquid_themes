require 'formatize/helper'

class Module
  # for the tezeilze method to work
  extend ActionView::Helpers::SanitizeHelper::ClassMethods
end

module CmsFilters

  include ActionView::Helpers::AssetTagHelper

  def translate(item)
    I18n.t(item)
  end

  def split_str(str, separator)
    str.split(separator)
  end

  def encode64(url)
    ActiveSupport::Base64.encode64(open(url) { |io| io.read })
  end

  def yaml_to_hash(str)
    YAML.load(str)
  end

  def russian_pluralize(col, str)
    ari = str.gsub(/ /, '').split(',')
    Russian.pluralize(col.to_i, ari[0], ari[1], ari[2])
  end

  def current_page_is(path)
    path_str=$1 if path =~ /(^.*)_path$/ or path =~/(^.*)_url$/
    path_options = Rails.application.routes.recognize_path(path_str)
    return 'path not found' if path_options.empty?

    $proxy_view.current_page?(path_options.to_a.join('/'))
  end

=begin
  def paginate_collection(collection, per_page=nil)
    return '' unless collection.respond_to?(:each) and !collection.empty?

    page = $proxy_view.controller.params[:page]
    per_page = $proxy_view.controller.params[:per_page] unless per_page
    collection.paginate :page => page, :per_page => per_page
  end

  def cms_paginator(collection)
    return '' unless collection.respond_to?(:each) and !collection.empty?

    $proxy_view.will_paginate(collection, :previous_label => "&#171; #{I18n.t('previous')}", :next_label => "#{I18n.t('next')} &#187;")
  end
=end

=begin
  def paginator_info(collection)
    return '' unless collection.respond_to?(:each) and !collection.empty?

    $proxy_view.page_entries_info collection, :entry_name => 'элемент', :plural_name => 'элементов'
  end
=end

  def translate(item)
    I18n.t(item)
  end

  def html_wrap(text, tag, cls = nil, id = nil)
    $proxy_view.content_tag tag.to_sym, text, :class => cls, :id => id
  end

  def strip_tags(html)
    HTML::FullSanitizer.new.sanitize(html).try(:html_safe)
  end

  def to_json(value)
    value.to_json
  end

  def url_encode(value)
    CGI::escape(value || '')
  end

  def url_decode(value)
    CGI::unescape(value || '')
  end

  def textilize(text, with_paragraphs = true)
    if with_paragraphs
      $proxy_view.textilize text
    else
      $proxy_view.textilize_without_paragraph text
    end
  end

  def javascript_include_tag(url)
    return '' if url.blank?

    $proxy_view.javascript_include_tag url
  end

  def stylesheet_link_tag(url)
    return '' if url.blank?

    $proxy_view.stylesheet_link_tag url
  end


  def javascript_tag(sources)
    return '' if sources.blank?

    site=@context.environments[0]['site']
    theme_javascripts_dir = File.join('/themes', site.theme_key, 'javascripts')
    sources.gsub(/ /, '').split(',').collect { |source| '<script type="text/javascript" src="'+theme_javascripts_dir+'/'+source+'"></script>' }.join("\n")
  end

  def stylesheet_tag(sources)
    return '' if sources.blank?

    site=@context.environments[0]['site']
    theme_stylesheets_dir = File.join('/themes', site.theme_key, 'stylesheets')
    sources.gsub(/ /, '').split(',').collect { |source| '<link href="'+theme_stylesheets_dir+'/'+source+'"  media="all" rel="stylesheet" type="text/css" />' }.join("\n")
  end

  def image_tag(url, title = nil, size = nil)
    return '' if url.blank?

    options = title.present? ? {:title => title, :alt => title} : {}
    options[:size] = size if size.present?
    aa=$proxy_view.image_tag url, options
    aa
  end

  def link_to(*params)
    return 'should_be_2_arguments' if params.nil? or params.size != 2
    path = params[1]

    if path.is_a?(String) and $proxy_view.respond_to?(path.to_sym)
      raw_str = $proxy_view.raw(params[0])
      @res = $proxy_view.raw($proxy_view.link_to(raw_str, $proxy_view.send(path.to_sym)))
    else
      raw_str = $proxy_view.raw(params[0])
      @res = $proxy_view.raw($proxy_view.link_to raw_str, path)
    end
    @res
  end

  def link_to_if(*params)
    return 'should_be_3_arguments' if params.nil? or params.size != 3
    condition = params[0]
    raw_str = $proxy_view.raw(params[1])
    path = params[2]

    if path.is_a?(String) and $proxy_view.respond_to?(path.to_sym)
      @res = $proxy_view.raw($proxy_view.link_to(raw_str, $proxy_view.send(path.to_sym)))
    else
      @res = $proxy_view.raw($proxy_view.link_to_if(condition, raw_str, path))
    end
    @res
  end

  def url_for(path)
    return '' if path.nil? or path == ''
    if $proxy_view.respond_to? path.to_sym
      @res = $proxy_view.send path.to_sym
    else
      @res = 'route_not_found'
    end
    @res
  end

  def items_for_collection(key, order='created_at asc', order_by_fields='created_at asc', per_page=5)
    return nil unless key
    items = Item.where(:collection_id => Collection.find_by_key(key), :published => true).order("#{order}").limit(per_page)
    aaa=items.to_a
    @context[key] = items.to_a
    ''
  end
 #TODO допилить крошки. сейчас не работает метод page.source.root
  def pages_breadcrums(page)
    page.source.root.self_and_descendants
  end

end

Liquid::Template.register_filter CmsFilters
