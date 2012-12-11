class ProductPropertyDrop < Cms::BaseDrop

  liquid_attributes << :id << :value << :product << :property

  def property_name
    @source.property_name
  end

end