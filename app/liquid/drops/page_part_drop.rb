class Refinery::PagePartDrop < Cms::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes =  [:created_at, :updated_at, :id, :page, :position]


  def initialize(source, options = {})
    super source
    @options ||= options
  end

  def context=(current_context)
    @context = current_context
  end

  def page_id
    @page_id ||= @source.refinery_page_id
  end

  def key
    @key ||= @source.title.underscore.split.join("_")
  end

  def body
    liquid = Liquid::Template.parse @source.body
    liquid.render(@context.environments[0])
  end

end