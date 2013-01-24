module Liquid

  # Capture stores the result of a block into a variable without rendering it inplace.
  #
  #   {% capture_variable heading %}
  #     Monkeys!
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
      render_all(@nodelist, context)
      context.scopes.last[@to] = context['pages_roots']
      ''
    end
  end

  Template.register_tag('capture_variable', CaptureVariable)
end
