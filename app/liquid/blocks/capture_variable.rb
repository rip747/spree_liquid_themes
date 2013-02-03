module Liquid

  # Capture stores the result of a block into a variable without rendering it inplace.
  #
  #   {% capture_variable heading %}
  #     {% my_tag param1:value1 param2:value2 %}
  #   {% endcapture_variable %}
  #   ...
  #   <h1>{{ heading }}</h1>
  #
  # Capture is useful for saving content for use later in your template, such as
  # in a sidebar or footer.
  #
  class CaptureVariable < Block
    Syntax = /(\w+)/

    def initialize(tag_name, markup, tokens)
      if markup =~ Syntax
        @to = $1
      else
        raise SyntaxError.new("Syntax Error in 'capture_variable' - Valid syntax: capture_variable [var]")
      end

      super
    end

    def render(context)
      context.scopes.last['capture_variable'] = @to
      render_all(@nodelist, context)
      context.scopes.last.except!('capture_variable')
      ''
    end
  end

  Template.register_tag('capture_variable', CaptureVariable)
end
