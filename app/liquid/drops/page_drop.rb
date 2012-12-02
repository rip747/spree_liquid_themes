class PageDrop < Cms::BaseDrop

  liquid_attributes.push(*[:link_url, :parts])

  def initialize(source)
    super
  end

end