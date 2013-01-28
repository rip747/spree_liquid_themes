class Spree::TaxonomyDrop < Clot::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:name, :taxons]

  def root
    @source.root
  end

end