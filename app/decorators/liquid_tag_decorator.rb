Liquid::Tag.class_eval do
  def render(context)
    @result ||= ''
    context['capture_variable'] ? context[context['capture_variable']] = @result : @result
  end

end