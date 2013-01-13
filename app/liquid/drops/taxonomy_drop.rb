class Spree::TaxonomyDrop < Liquid::Core::BaseDrop
  
  liquid_attributes << :name << :taxons << :root << :parent << :children
  
end