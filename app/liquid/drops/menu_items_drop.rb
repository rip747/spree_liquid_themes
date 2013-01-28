class Refinery::MenuItemsDrop < Liquid::Drop

  #class_attribute :liquid_attributes
  #self.liquid_attributes =  [:title, :parent_id, :depth, :url, :menu, :menu_match]

  #def initialize(source, options = {})
  #  super source
  #  @options ||= options
  #end

  def initialize(snippets)
    @snippets = snippets # List of valid snippet names
  end
  def before_method(meth) # Catch all
    Refinery::MenuItemDrop.new(meth) if @snippets.contains?(meth)
  end

end