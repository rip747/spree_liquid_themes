class Spree::ImageDrop < Liquid::Core::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:attachment, :alt]
  
end