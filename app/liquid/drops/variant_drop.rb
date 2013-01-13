class Spree::VariantDrop < Liquid::Core::BaseDrop

    liquid_attributes.push(*[:id, :product, :sku, :price, :weight, :height, :width, :depth, :deleted_at, :is_master,
                             :in_stock,:count_on_hand, :cost_price, :position , :images, :inventory_units,
                             :line_items, :option_values
  ])

  def available?
    @source.available?
  end

  def options_text
    @source.options_text
  end

  def gross_profit
    @source.gross_profit
  end

  def deleted?
    @source.deleted?
  end

=begin
  def active
    Variant.active
  end
=end

end