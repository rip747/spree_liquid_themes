require 'action_view/template/handlers/liquid'
ActionView::Template.register_template_handler :liquid, ActionView::Template::Handlers::Liquid

ActionController::Base.prepend_view_path  Rails.root.join("themes/#{Refinery::Themes::Theme.current_theme_key}/views")
Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/javascripts").to_s
Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/stylesheets").to_s
Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/images").to_s