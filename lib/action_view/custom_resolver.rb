#class LiquidResolver < ::ActionView::FileSystemResolver
#  def initialize
#    super(Rails.root.join("themes/#{Refinery::Themes::Theme.current_theme_key}/views").to_s)
#  end
#
#  def find_templates(name, prefix, partial, details)
#    super(name, prefix, partial, details)
#  end
#end