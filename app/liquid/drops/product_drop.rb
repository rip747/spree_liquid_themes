class Spree::ProductDrop < Clot::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:id, :name, :description, :price, :permalink,
                           :available_on, :shipping_category, :deleted_at,
                           :meta_description, :meta_keywords, :count_on_hand, :product_option_types,
                           :option_types, :product_properties, :properties, :taxons,
                           :master, :variants,  :variants_including_master
  ]

  def initialize(source, options = {})
    super source
    @options ||= options
  end

  def get_source
    @source
  end

  def variant_images
    @source.variant_images
  end
end