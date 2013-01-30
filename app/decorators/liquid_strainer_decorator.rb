Liquid::Strainer.class_eval do
  include ActionView::Helpers

  def initialize(context)
    @context = context
  end

  def controller
    @controller ||= @context.registers[:controller]
  end

end