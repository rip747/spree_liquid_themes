class Spree::LineItemDrop < Liquid::Core::BaseDrop

  liquid_attributes << :id << :quantity << :price << :product << :order << :variant

  def increment_quantity
    @source.quantity += 1
  end

  def decrement_quantity
    @source.quantity -= 1
  end

  def amount
    @source.price * @source.quantity
  end

  def total_amount
    amount
  end

  def adjust_quantity
    @source.quantity = 0 if @source.quantity.nil? || @source.quantity < 0
  end

  def copy_price
    @source.price = @source.variant.price if @source.variant && @source.price.nil?
  end

end