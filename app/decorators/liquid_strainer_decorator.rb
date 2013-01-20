Liquid::Strainer.class_eval do
  include ActionView::Context
  include ActionView::Helpers

  #include ActionView::Helpers::TextHelper
  #include ActionView::Helpers::SanitizeHelper
  #include ActionView::Helpers::NumberHelper
  #include ActionView::Helpers::AssetTagHelper
  #include ActionView::Helpers::JavaScriptHelper
  #include ActionView::Helpers::UrlHelper
  #include ActionView::Helpers::TagHelper
  #include ActionView::Helpers::AtomFeedHelper
  #include ActionView::Helpers::CacheHelper
  #include ActionView::Helpers::ActiveModelHelper
  #include ActionView::Helpers::CaptureHelper
  #include ActionView::Helpers::CsrfHelper
  #include ActionView::Helpers::DateHelper
  #include ActionView::Helpers::FormHelper
  #include ActionView::Helpers::FormOptionsHelper
  #include ActionView::Helpers::FormTagHelper
  #include ActionView::Helpers::RecordTagHelper
  #include ActionView::Helpers::TranslationHelper


  def controller
    @controller ||= @context.registers[:controller]
  end

  #def action_view
  #  @action_view ||= @context.registers[:action_view]
  #end

  delegate :request, :to => :controller
  delegate :params, :to => :request
end