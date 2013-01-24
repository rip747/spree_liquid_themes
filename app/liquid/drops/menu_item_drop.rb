class Refinery::MenuItemDrop < Liquid::Core::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes =  [:title, :parent_id, :lft, :rgt, :depth, :url, :menu, :menu_match]

  def initialize(source, options = {})
    super source
    @options ||= options
  end

end