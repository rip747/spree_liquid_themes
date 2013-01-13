class Spree::PropertyDrop < Liquid::Core::BaseDrop
  
  liquid_attributes << :id << :name << :presentation << :prototypes << :product_properties << :products
  
end