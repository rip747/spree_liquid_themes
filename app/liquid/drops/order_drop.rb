class Spree::OrderDrop < Clot::BaseDrop

  self.liquid_attributes = [:id, :line_items,  :user, :adjustments, :number, :email,
                            :total, :item_total, :ship_total, :adjustment_total, :state, :tax_total,
                            :special_instructions]

  def token
    @source.token
  end

  def display_total
    @source.display_total
  end

  def display_item_total
    @source.display_item_total
  end

  def bill_address
    @source.bill_address
  end

  def ship_address
    @source.ship_address
  end

end