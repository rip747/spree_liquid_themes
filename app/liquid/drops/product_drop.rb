class Spree::ProductDrop < Liquid::Core::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:id, :name, :description, :price, :permalink,
                           :available_on, :shipping_category, :deleted_at,
                           :meta_description, :meta_keywords, :count_on_hand, :product_option_types,
                           :option_types, :product_properties, :properties, :images, :taxons,
                           :master, :variants,  :variants_including_master
  ]

end