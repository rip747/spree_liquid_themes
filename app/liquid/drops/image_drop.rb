class Spree::ImageDrop < Clot::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes = [:attachment, :alt]

  def url_for()
    @source.attachment.url(:mini)
  end
  
end