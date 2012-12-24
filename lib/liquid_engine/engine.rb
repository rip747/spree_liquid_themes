require "extras/liquid_view"

module LiquidEngine
  class Engine < Rails::Engine
    include Refinery::Engine
    isolate_namespace LiquidEngine

    engine_name :liquid_engine

    def self.activate

      ActionController::Base.prepend_view_path  Rails.root.join("themes/#{Refinery::Themes::Theme.current_theme}/views")

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

      ActiveRecord::Base.send(:include, Liquid::ActiveRecord::Droppable)

    end

    initializer "register liquid_engine plugin" do
      Refinery::Plugin.register do |plugin|
        plugin.name = "liquid_engine"
        plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.themes_admin_themes_path }
        plugin.pathname = root
        plugin.menu_match = %r{refinery/themes(/.+?)?$}#/refinery\/themes$/
        #plugin.activity = {
        #    :class_name => :'refinery/themes/theme'#, :title => 'name'
        #}

      end
    end

    config.after_initialize do
      Refinery.register_extension(LiquidEngine)
    end

    config.to_prepare &method(:activate).to_proc

  end
end