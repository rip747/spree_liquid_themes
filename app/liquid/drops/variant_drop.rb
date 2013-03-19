class Spree::VariantDrop < Clot::BaseDrop

  self.liquid_attributes = [:id, :sku, :price, :weight, :height, :width, :depth, :deleted_at, :is_master,
                             :in_stock,:count_on_hand, :cost_price, :position , :images, :inventory_units,
                             :line_items, :option_values
  ]

  def available?
    @source.available?
  end

  def deleted?
    @source.deleted?
  end

  def product
    @source.product
  end

  def options_text
    @source.options_text
  end

  def images
    @source.images
  end

  def display_amount
    @source.display_amount
  end

  def prices
    @source.prices
  end

  def default_price
    @source.default_price
  end

end