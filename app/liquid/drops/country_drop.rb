class Spree::CountryDrop < Clot::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:id, :name, :states]
  
end