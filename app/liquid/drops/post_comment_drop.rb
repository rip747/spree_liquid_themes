class Refinery::Blog::CommentDrop < Clot::BaseDrop

  self.liquid_attributes = [:created_at, :updated_at, :id, :post, :spam, :name, :email, :body, :state]

end