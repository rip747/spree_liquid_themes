module RailsFilters

  def truncate(text, length = 50)
    Protected.truncate(text, length)
  end


  def yaml_to_hash(str)
    YAML.load(str)
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

  def time_now(format)
    Time.now.strftime(format)
  end

  def script_tag(url)
    Protected.config = @context.registers[:controller]
    Protected.javascript_include_tag url
  end

  def stylesheet_tag(url)
    return '' if url.blank?

    Protected.config = @context.registers[:controller]
    Protected.stylesheet_link_tag url
  end

  def image_tag(url, title = nil, size = nil)
    return '' if url.blank?

    Protected.config = @context.registers[:controller]

    options = title.present? ? {:title => title, :alt => title} : {}
    options[:size] = size if size.present?
    Protected.image_tag url, options
  end

  def link_to(text, url)
    Protected.link_to text, url
  end

  def url_helper(*args)
    return '' if args.empty?
    url_helper = args.shift.to_sym

    # TODO refactoring this
    if Refinery::Core::Engine.routes.url_helpers.respond_to? url_helper
      args.empty? ? Refinery::Core::Engine.routes.url_helpers.send(url_helper) || 'not found' : Refinery::Core::Engine.routes.url_helpers.send(url_helper, *args) || 'not found'
    elsif Spree::Core::Engine.routes.url_helpers.respond_to? url_helper
      args.empty? ? Spree::Core::Engine.routes.url_helpers.send(url_helper) || 'not found' : Spree::Core::Engine.routes.url_helpers.send(url_helper, *args) || 'not found'
    elsif Rails.application.routes.url_helpers.respond_to? url_helper
      args.empty? ? Rails.application.routes.url_helpers.send(url_helper) || 'not found' : Rails.application.routes.url_helpers.send(url_helper, *args) || 'not found'
    else
      'not found'
    end
  end

  def url_for(obj)
    Protected.config = @context.registers[:controller]
    Protected.url_for(obj) || 'not found'
  end

end

Liquid::Template.register_filter RailsFilters
