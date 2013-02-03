class Refinery::Blog::CategoryDrop < Clot::BaseDrop

  self.liquid_attributes = [:created_at, :updated_at, :id, :title, :cached_slug, :slug, :posts]

end