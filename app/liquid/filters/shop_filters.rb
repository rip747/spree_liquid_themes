module ShopFilters

  include ActionView::Helpers::AssetTagHelper

  def products_paginator(collection)
    if collection.respond_to?(:num_pages)
      $proxy_view.controller.params.delete(:search)
      $proxy_view.controller.params.delete(:taxon)
    end
    $proxy_view.paginate(collection)
  end

  def currency(price, unit = "$", precision = 0)
    #$proxy_view.number_to_currency(price, :unit => unit, :precision => precision)
    $proxy_view.number_to_currency(price)
  end

  def small_image(product)
    $proxy_view.link_to $proxy_view.small_image(product.source), $proxy_view.controller.product_path(product.source)
  end

  def attachment_image_tag(obj, type = 'original', title = nil, size = nil)
    return '' unless obj

    options = title.present? ? {:title => title, :alt => title} : {}
    options[:size] = size if size.present?
    $proxy_view.raw($proxy_view.image_tag obj.source.attachment.url(type.to_sym), options)
  end

  def image_attachment_url(obj, type = 'original')
    return '' unless obj
    $proxy_view.raw(obj.source.attachment.url(type.to_sym))
  end

  def product_price(obj)
    $proxy_view.product_price(obj.source)
  end

  def product_description(product)
    $proxy_view.product_description(product.source) rescue I18n("product_has_no_description")
  end

  def product_image(product)
    $proxy_view.product_image(product.source)
  end

  def shop_config_for(value)
    Spree::Config[value.to_sym]
  end

  def variant_options(variant)
    $proxy_view.variant_options(variant.source)
  end

  def variant_price_diff(variant)
    $proxy_view.variant_price_diff(variant.source)
  end

  def order_price(order)
    $proxy_view.order_price(order.source)
  end

  def link_to_taxon(taxon)
    $proxy_view.raw($proxy_view.link_to taxon.source.name, $proxy_view.seo_url(taxon.source))
  end

  def taxon_preview(taxon, max=5)
    $proxy_view.taxon_preview(taxon.source, max)
  end

  def seo_url(taxon)
    $proxy_view.seo_url(taxon.source)
  end

  def make_taxons_tree(array, current_taxon=nil)
    current_taxon.nil? ? nil : ct = current_taxon.source
    $proxy_view.raw $proxy_view.make_taxons_tree(array, ct)
  end

  def properties_for_product(product)
    @context['product_properties'] = ProductProperty.find_all_by_product_id(product.source.id, :include => [:property])
    ''
  end

  def promotions_for(product)
    $proxy_view.promotions_for(product.source)
  end

  def product_url(product)
   # $proxy_view.product_url(product)
    "http://#{$proxy_view.site.default_domain}/products/#{product.source.permalink}"
  end

end

Liquid::Template.register_filter ShopFilters
