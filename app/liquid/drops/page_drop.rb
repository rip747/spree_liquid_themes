class Refinery::PageDrop < Clot::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes =  [:created_at, :updated_at, :id, :slug, :parts]

  def initialize(source, options = {})
    super source
    @options ||= options
  end

  #TODO
  #def part_by_key(key)
  #  @source.parts.find_by_key key
  #end

end