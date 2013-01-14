class Spree::StateDrop < Liquid::Core::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:name, :country, :locations]
  
end