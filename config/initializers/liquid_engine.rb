require 'action_view/template/handlers/liquid'
ActionView::Template.register_template_handler :liquid, ActionView::Template::Handlers::Liquid

#ActionController::Base.prepend_view_path  Refinery::Themes::Theme.theme_path.join("views")

Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/javascripts").to_s
Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/stylesheets").to_s
Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/images").to_s

I18n.load_path += Dir[Refinery::Themes::Theme.theme_path.join('config', 'locales', '*.{rb,yml}').to_s]