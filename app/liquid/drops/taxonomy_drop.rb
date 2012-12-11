class TaxonomyDrop < Cms::BaseDrop
  
  liquid_attributes << :name << :taxons << :root << :parent << :children
  
end