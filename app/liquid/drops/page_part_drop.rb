class PagePartDrop < Cms::BaseDrop

  liquid_attributes.push(*[:page, :title, :body, :refinery_page_id])


  def initialize(source)
    super
  end

end