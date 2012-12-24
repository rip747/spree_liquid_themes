require 'action_view/template/handlers/liquid'
ActionView::Template.register_template_handler :liquid, ActionView::Template::Handlers::Liquid

Rails.application.config.assets.paths << Refinery::Themes::Theme.current_theme_path.join("assets/javascripts")
Rails.application.config.assets.paths << Refinery::Themes::Theme.current_theme_path.join("assets/stylesheets")
Rails.application.config.assets.paths << Refinery::Themes::Theme.current_theme_path.join("assets/images")