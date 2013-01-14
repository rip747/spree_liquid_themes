class Spree::TaxonDrop < Liquid::Core::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:name, :taxonomy, :children, :parent, :siblings, :ancestors]

  def products
    ProductsDrop.new(@source)
  end

end
