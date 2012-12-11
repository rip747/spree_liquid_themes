class ItemDrop < Cms::BaseDrop

  liquid_attributes << :id << :key << :path << :permalink

=begin
  def initialize(source)
    super
    @source.collection.fields.each do |f|
      @liquid += {f.key => @source.contents.to_ary.find { |c| c.field_id == f.id }.parse(f.kind)}
    end
  end
=end

  def initialize(source)
    super
  end

  def context=(current_context)
    unless current_context["item_rendered_flag_#{@source.id}"]
      @source.contents.each do |content|
        f=content.field
        assigns = {}
        current_context.environments.collect { |h| assigns.update(h) }
        if content.field.kind == 'html' or content.field.kind == 'text' or content.field.kind == 'string' or content.field.kind == 'md'
          @item_content = Liquid::Template.parse(content.value)
          result= @item_content.render(assigns, :registers => {:controller => current_context.registers[:controller]})
          content.value = result.respond_to?(:join) ? result.join : result
          assigns.update(@item_content.instance_assigns)
          assigns.update(@item_content.assigns)
        end
        assigns["item_rendered_flag_#{@source.id}"] = true
        current_context.environments[0].update(assigns)
        @liquid += {f.key => @source.contents.to_ary.find { |c| c.field_id == f.id }.parse(f.kind)}
      end
    else
    #  current_context.environments.delete("item_rendered_flag_#{@source.id}")
      @source.collection.fields.each do |f|
        @liquid += {f.key => @source.contents.to_ary.find { |c| c.field_id == f.id }.parse(f.kind)}
      end
    end

    super
  end


  def id
    @source.id
  end

  # TODO - swap this so the url is the native method
  def url
    @source.permalink
  end

  def path
    @source.path
  end

  def published_at
    @source.published_at.to_s(:short)
  end

end
