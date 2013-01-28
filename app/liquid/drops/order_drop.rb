class Spree::OrderDrop < Clot::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:id, :line_items, :ship_address, :bill_address, :user, :adjustments, :number, :email,
                           :total, :item_total, :ship_total, :credit_total, :adjustment_total, :state, :tax_total,
                           :special_instructions]

  def token
    @source.token
  end

end