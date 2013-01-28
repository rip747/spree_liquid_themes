class ImageForProduct < Liquid::Tag

  def initialize(tag_name, markup, tokens)
    unless markup.empty?
      if markup =~ /style:([-_a-z0-9]+)/
        @style = $1
      end
    end

    super
  end

  def render(context)
    context.registers[:action_view].send("#{@style}_image".to_sym, context["product"].source)
  end
end

Liquid::Template.register_tag('image_for_product', ImageForProduct)

########################################################################################################################

class GetProducts < Liquid::Tag

  def initialize(tag_name, markup, tokens)
    unless markup.empty?
      if markup =~ /per_page:(\d+)/
        @per_page = $1.to_i
      end

      if markup =~ /type:([-_a-z0-9]+)/
        @type = $1
      end
    end

    @per_page ||= 5

    super
  end

  def render(context)
    @searcher = Spree::Config.searcher_class.new(context.registers[:controller].params)
    @searcher.current_user = context.registers[:controller].try_spree_current_user
    @searcher.current_currency = context.registers[:action_view].current_currency
    @products = @searcher.retrieve_products

    if @type == 'latest'

    end

    if context['capture_variable']
      context[context['capture_variable']] ||= @products.per(@per_page)
    else
      context['products'] ||= @products.per(@per_page)
    end

    ''
  end
end

Liquid::Template.register_tag('get_products', GetProducts)

########################################################################################################################


class GetProductsByTaxon < Liquid::Tag

  def initialize(tag_name, markup, tokens)
    unless markup.empty?
      if markup =~ /per_page:(\d+)/
        @per_page = $1.to_i
      end

      if markup =~ /taxon:([\/-_a-z0-9]+)/
        @taxon_name = $1
      end

      if markup =~ /type:([_a-z0-9]+)/
        @type = $1
      end
    end

    @per_page ||= 5

    super
  end

  def render(context)
    @taxon = Spree::Taxon.find_by_permalink!(@taxon_name)
    return unless @taxon

    context[@taxon_name] = @taxon

    @searcher = Spree::Config.searcher_class.new(context.registers[:controller].params.merge(:taxon => @taxon.id))
    @searcher.current_user = context.registers[:controller].try_spree_current_user
    @searcher.current_currency = context.registers[:action_view].current_currency
    @products = @searcher.retrieve_products

    if @type == 'latest'

    end

    if context['capture_variable']
      context[context['capture_variable']] = @products.per(@per_page)
    else
      context['products'] = @products.per(@per_page)
    end

    ''
  end
end

Liquid::Template.register_tag('get_products_by_taxon', GetProductsByTaxon)