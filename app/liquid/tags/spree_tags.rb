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
    @result = context.registers[:action_view].send("#{@style}_image".to_sym, context["product"].source)
    super(context)
  end
end

Liquid::Template.register_tag('image_for_product', ImageForProduct)

########################################################################################################################

class VariantsFor < Liquid::Tag

  def initialize(tag_name, markup, tokens)
    unless markup.empty?
      if markup =~ /([-_a-z0-9]+)/
        @object = $1
      end
    end

    super
  end


  def render(context)
    return "object with name #{@object} not found" if context[@object].nil?
    @product = context[@object].source
    @result = context.registers[:action_view].render(:partial => 'spree/products/variants')
    super(context)
  end
end

Liquid::Template.register_tag('variants_for', VariantsFor)

########################################################################################################################


class ProductImageUrl < Liquid::Tag

  def initialize(tag_name, markup, tokens)
    unless markup.empty?
      if markup =~ /style:([-_a-z0-9]+)/
        @style = $1
      end

      if markup =~ /object:([-_a-z0-9]+)/
        @object = $1
      end
    end

    @object ||= 'product'

    super
  end

  def render(context)
    @result = context[@object].source.images.first.attachment.url(@style.to_sym)
    super(context)
  end
end

Liquid::Template.register_tag('product_image_url', ProductImageUrl)

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
    context.registers[:controller].params[:per_page] = @per_page
    @searcher = Spree::Config.searcher_class.new(context.registers[:controller].params)
    @searcher.current_user = context.registers[:controller].try_spree_current_user
    @searcher.current_currency = context.registers[:action_view].current_currency
    @result = @searcher.retrieve_products

    context['products'] = @result
    super(context)
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
    @searcher.current_user = context.registers[:controller].spree_current_user
    @searcher.current_currency = Spree::Config[:currency]
    @products = @searcher.retrieve_products

    @result = @products.per(@per_page)
    context['products'] = @products.per(@per_page)

    super(context)
  end
end

Liquid::Template.register_tag('get_products_by_taxon', GetProductsByTaxon)

########################################################################################################################

class PromoCount < Liquid::Tag

  def render(context)
    Spree::Promotion.count
    super(context)
  end
end

Liquid::Template.register_tag('promotion_count', PromoCount)

########################################################################################################################


class SpreeSearchForm < Liquid::Tag

  def render(context)
    @result = context.registers[:action_view].render(:partial => 'spree/shared/search')
    super(context)
  end
end

Liquid::Template.register_tag('spree_search_form', SpreeSearchForm)

########################################################################################################################
class ProductsFilters < Liquid::Tag
  def render(context)
    # imported from spree/shared/_filters.html.erb
    template = context.registers[:action_view]
    filters = context['taxon'] ? context['taxon'].source.applicable_filters : [::Spree::ProductFilters.all_taxons]
    template.params[:search] ||= {}
    @result = context['filters'] = filters.map { |filter|
      filter[:labels] || filter[:conds].map { |m, c| [m, m] }
      filter[:inputs] = []
      next if filter[:labels].empty?
      filter[:labels] = filter[:labels].map do |nm, val|
        label = "#{filter[:name]}_#{nm}".gsub(/\s+/, '_')
        filter[:inputs] << template.tag(
            :input,
            :type => 'checkbox',
            :id => label,
            :name => "search[#{filter[:scope].to_s}][]",
            :value => val,
            :checked => (template.params[:search][filter[:scope]] && template.params[:search][filter[:scope]].include?(val.to_s))
        )
        template.content_tag(:label, :for => label) do
          nm
        end
      end
      filter.stringify_keys
    }
    super(context)
  end
end

Liquid::Template.register_tag('products_filters', ProductsFilters)

########################################################################################################################
