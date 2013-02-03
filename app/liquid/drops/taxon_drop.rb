class Spree::TaxonDrop < Clot::BaseDrop

  self.liquid_attributes = [:name, :description, :children, :products, :taxonomy, :parent, :siblings, :ancestors]

  def children
    @source.children
  end

  def permalink
    @source.permalink
  end
end
