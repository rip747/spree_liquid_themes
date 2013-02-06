class Spree::TaxonDrop < Clot::BaseDrop

  self.liquid_attributes = [:name, :description, :children, :products, :taxonomy, :parent]

  def siblings
    @source.siblings
  end

  def self_and_ancestors
    @source.self_and_ancestors
  end

  def ancestors
    @source.ancestors
  end

  def children
    @source.children
  end

  def permalink
    @source.permalink
  end
end
