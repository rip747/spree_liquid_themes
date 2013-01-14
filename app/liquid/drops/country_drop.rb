class Spree::CountryDrop < Liquid::Core::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:id, :name, :states]
  
end