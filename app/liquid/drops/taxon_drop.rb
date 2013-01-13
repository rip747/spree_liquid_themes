class Spree::TaxonDrop < Liquid::Core::BaseDrop

  liquid_attributes << :name << :taxonomy << :children << :parent << :siblings << :ancestors

  def products
    ProductsDrop.new(@source)
  end

end
