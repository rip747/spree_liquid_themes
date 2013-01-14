class Spree::PropertyDrop < Liquid::Core::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:id, :name, :presentation, :prototypes, :product_properties, :products]
  
end