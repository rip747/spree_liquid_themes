class ProductDrop < Cms::BaseDrop

  liquid_attributes.push(*[:id, :name, :description, :price, :permalink,
                           :available_on, :shipping_category, :deleted_at,
                           :meta_description, :meta_keywords, :count_on_hand, :product_option_types,
                           :option_types, :product_properties, :properties, :images, :product_groups, :taxons,
                           :master, :variants,  :variants_including_master
  ])


  def has_variants?
    @source.has_variants?
  end

  def on_hand
    @source.on_hand
  end

  def to_param
    @source.to_param
  end

  def has_stock?
    @source.has_stock?
  end

  def tax_category
    @source.tax_category
  end

  def deleted?
    @source.deleted?
  end

  def active_variants
    @source.variants.active
  end

end