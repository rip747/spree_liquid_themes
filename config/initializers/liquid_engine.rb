require 'action_view/template/handlers/liquid'
ActionView::Template.register_template_handler :liquid, ActionView::Template::Handlers::Liquid

#Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/javascripts")
#Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/stylesheets")
#Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/images")

FileUtils.ln_sf(Refinery::Themes::Theme.theme_path, Rails.root.join('themes/current')) unless File.exist?(Rails.root.join('themes/current'))

Rails.application.config.assets.paths << Rails.root.join("themes/current/assets/javascripts")
Rails.application.config.assets.paths << Rails.root.join("themes/current/assets/stylesheets")
Rails.application.config.assets.paths << Rails.root.join("themes/current/assets/images")