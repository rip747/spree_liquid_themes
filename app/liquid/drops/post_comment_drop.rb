class Refinery::Blog::CommentDrop < Clot::BaseDrop

  self.liquid_attributes = [:post, :spam, :name, :email, :message]

  def message
    @source.message.html_safe
  end
end