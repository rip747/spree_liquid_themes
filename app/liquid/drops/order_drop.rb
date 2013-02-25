class Spree::OrderDrop < Clot::BaseDrop

  self.liquid_attributes = [:id, :line_items,  :user, :adjustments, :number, :email, :total, :item_total, :ship_total,
                            :adjustment_total, :state, :tax_total, :special_instructions]

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

  def rate_hash
   @source.rate_hash.inject([]) do |result, rate|
      hash = {}
      hash['shipping_method'] = rate.shipping_method
      hash['name'] = rate.name
      hash['cost'] = rate.cost
      hash['currency'] = rate.currency
      hash['id'] = rate.id
      hash['display_price'] = rate.display_price
      result << hash
   end
  end

end