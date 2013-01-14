class Refinery::UserDrop < Liquid::Core::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:email, :login, :ship_address, :bill_address, :orders, :roles]
  
end