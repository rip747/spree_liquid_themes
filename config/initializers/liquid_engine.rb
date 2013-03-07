require 'action_view/template/handlers/liquid'
ActionView::Template.register_template_handler :liquid, ActionView::Template::Handlers::Liquid

ActionController::Base.prepend_view_path  Rails.root.join("themes/#{Refinery::Themes::Theme.current_theme_key}/views")
Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/javascripts")
Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/stylesheets")
Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/images")