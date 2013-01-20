class Spree::TaxonDrop < Liquid::Core::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:name]

  def products
    #ProductsDrop.new(@source)
    @source.products
  end

  def children
    @source.children
  end

  def taxonomy
    @source.taxonomy
  end

  def parent
    @source.parent
  end

  def siblings
    @source.siblings
  end

  def ancestors
    @source.ancestors
  end

end
