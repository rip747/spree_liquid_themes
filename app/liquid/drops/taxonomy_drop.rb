class Spree::TaxonomyDrop < Liquid::Core::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:name, :taxons, :root, :parent, :children]

end