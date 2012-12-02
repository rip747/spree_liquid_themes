class CategoryBlocks < Liquid::Tag
  def initialize(tag_name, category, tokens)
    super
    @name = category
  end

  def render(context)
    blocks = Refinery::Blocks::Block.visibled_by_category(Refinery::Blocks::Category.find_by_title(@name).id)
    return 'not found blocks for category' if blocks.empty?
    context['blocks'] = blocks
    ''
  end
end

class SimpleBlock < Liquid::Tag
  def initialize(tag_name, block, tokens)
    super
    @name = block
  end

  def render(context)
    block = Refinery::Blocks::Block.where(:title => @name, :visible => true).first
    return 'not found block by name' if block.nil?
    context['block'] = block
    ''
  end
end


Liquid::Template.register_tag('get_blocks_for_category', CategoryBlocks)
Liquid::Template.register_tag('get_block_by_name', SimpleBlock)