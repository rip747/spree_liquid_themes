=begin
class GetTaxonomies < Clot::ClotTag
  include Spree::ProductsHelper

  #def initialize(tag_name, markup, tokens)
  #  super
  #  @name = markup
  #end

  def render(context)
    get_taxonomies
  end
end

Liquid::Template.register_tag('get_taxonomies', GetTaxonomies)
=end
