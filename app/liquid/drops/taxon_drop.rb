class TaxonDrop < Cms::BaseDrop

  liquid_attributes << :name << :taxonomy << :children << :parent << :siblings << :ancestors
 # liquid_methods << :parent? << :ancestors

  def products
    ProductsDrop.new(@source)
  end

end

class ProductsDrop < Clot::BaseDrop

  def active
    @source.products.active.uniq
  end

end