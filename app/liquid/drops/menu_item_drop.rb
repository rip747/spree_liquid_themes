class Refinery::MenuItemDrop < Clot::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes =  [:title, :parent, :depth, :menu, :menu_match]

  def initialize(source, options = {})
    super source
    @options ||= options
  end

  def url
    @context.registers[:action_view].url_for(@source.url)
  end

  def children
    @source.children
  end

  def ancestors
    @source.ancestors
  end

end