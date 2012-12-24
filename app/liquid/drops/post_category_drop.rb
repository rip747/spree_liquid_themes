class Refinery::Blog::CategoryDrop < Cms::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes =  [:created_at, :updated_at, :id, :title, :cached_slug, :slug, :posts]

  def initialize(source, options = {})
    super source
    @options ||= options
  end
end