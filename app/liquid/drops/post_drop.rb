class Refinery::Blog::PostDrop < Clot::BaseDrop

  self.liquid_attributes = [:created_at, :updated_at, :id, :draft, :published_at, :author, :cached_slug,
                            :custom_url, :custom_teaser, :source_url, :source_url_title, :access_count, :slug,
                            :categories, :comments]

  def body
    liquid = Liquid::Template.parse @source.body
    liquid.render(@context.environments[0])
  end

  def title
    liquid = Liquid::Template.parse @source.title
    liquid.render(@context.environments[0])
  end

  def live?
    @source.live?
  end

end