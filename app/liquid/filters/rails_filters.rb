module RailsFilters

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

  def url_for(item, url_helper)
    @context.registers[:action_view].url_for(@source.url)
    #result = Rails.application.routes.url_helpers.try(url_helper.to_sym, item.source) if Rails.application.routes.url_helpers.respond_to?(url_helper.to_sym)
    #result = Refinery::Core::Engine.routes.url_helpers.try(url_helper.to_sym, item.source) if Refinery::Core::Engine.routes.url_helpers.respond_to?(url_helper.to_sym)
    #result = Spree::Core::Engine.routes.url_helpers.try(url_helper.to_sym, item.source)    if Spree::Core::Engine.routes.url_helpers.respond_to?(url_helper.to_sym)
    result || 'not found'
  end

end

Liquid::Template.register_filter RailsFilters
