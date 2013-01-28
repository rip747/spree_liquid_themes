class Spree::ProductPropertyDrop < Clot::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:id, :value, :product, :property]

  def property_name
    @source.property_name
  end

end