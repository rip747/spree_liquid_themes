module Protected
  extend ERB::Util
  #extend Formatize::Helper
  extend ActionView::Helpers::TextHelper
  extend ActionView::Helpers::SanitizeHelper
  extend ActionView::Helpers::NumberHelper
  extend ActionView::Helpers::TagHelper
  extend ActionView::Helpers::AssetTagHelper
  extend ActionView::Helpers::UrlHelper

  def self.config=(controller)
    @controller = controller
  end
  def self.config
    @controller
  end
  def self.controller
    @controller
  end
end
