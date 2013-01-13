class Spree::CountryDrop < Liquid::Core::BaseDrop
  
  liquid_attributes << :id << :name << :states
  
end