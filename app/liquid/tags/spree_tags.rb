class ImageForProduct < Clot::ClotTag
  include Spree::ProductsHelper

  def initialize(tag_name, markup, tokens)
    unless markup.empty?
      if markup =~ /style:([_a-z0-9]+)/
        @style = $1
      end
    end

    super
  end

  def render(context)
    context.registers[:action_view].send("#{@style}_image".to_sym, context["product"].source)
  end
end

Liquid::Template.register_tag('image_for_product', ImageForProduct)

