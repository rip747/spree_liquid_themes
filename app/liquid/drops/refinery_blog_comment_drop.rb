class Refinery::Blog::CommentDrop < Clot::BaseDrop

  self.liquid_attributes = [:id, :created_at, :updated_at, :email, :name]

  def message
    liquid = Liquid::Template.parse @source.message.html_safe
    liquid.render(@context.environments[0])
  end

end
