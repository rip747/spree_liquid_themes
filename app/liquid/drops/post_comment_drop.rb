class Refinery::Blog::CommentDrop < Liquid::Core::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes =  [:created_at, :updated_at, :id, :post, :spam, :name, :email, :body, :state]

  def initialize(source, options = {})
    super source
    @options ||= options
  end

end