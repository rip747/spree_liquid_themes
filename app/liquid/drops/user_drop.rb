class Refinery::UserDrop < Liquid::Core::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:email, :login]

  def orders
    @source.orders
  end

  def roles
    @source.roles
  end

  def ship_address
    @source.ship_address
  end

  def bill_address
    @source.bill_address
  end
  
end