module Spreefinery
  class Engine < Rails::Engine
    include Refinery::Engine
    isolate_namespace Spreefinery::Engine

    engine_name :spreefinery

    def self.activate

      #ActionController::Base.prepend_view_path(Rails.root.join("themes/#{Refinery::Themes::Theme.current_theme_key}/views"))
      ActionController::Base.prepend_view_path(Rails.root.join("themes/current/views"))

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/overrides/**/*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      Dir[root + 'lib/liquid/**/*.rb'].each { |f| Rails.configuration.cache_classes ? require(f) : load(f) }

      %w{. tags drops filters blocks}.each do |dir|
        Dir[File.join(File.dirname(__FILE__), '../../app/liquid', dir, '*.rb')].each { |lib| Rails.configuration.cache_classes ? require(lib) : load(lib) }
      end

     # ::ActiveRecord::Base.send(:include, Liquid::ActiveRecord::Droppable)

    end

    initializer "register spreefinery plugin" do
      Refinery::Plugin.register do |plugin|
        plugin.name = "spreefinery"
        plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.themes_admin_themes_path }
        plugin.pathname = root
        plugin.menu_match = /refinery\/themes\/?(settings|editor|upload)?/
      end
    end

    config.after_initialize do
      Refinery.register_extension(Spreefinery::Engine)
    end

    config.to_prepare &method(:activate).to_proc

  end
end