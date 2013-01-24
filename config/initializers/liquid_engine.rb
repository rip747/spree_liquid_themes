require 'action_view/template/handlers/liquid'
ActionView::Template.register_template_handler :liquid, ActionView::Template::Handlers::Liquid

FileUtils.ln_sf(Refinery::Themes::Theme.theme_path, Rails.root.join('themes/current')) unless File.exist?(Rails.root.join('themes/current'))

Rails.application.config.assets.paths << Rails.root.join("themes/current/assets/javascripts")
Rails.application.config.assets.paths << Rails.root.join("themes/current/assets/stylesheets")
Rails.application.config.assets.paths << Rails.root.join("themes/current/assets/images")