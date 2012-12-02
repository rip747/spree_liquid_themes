module LiquidEngine
  class Engine < Rails::Engine
    isolate_namespace ::LiquidEngine

    engine_name :liquid_engine

    def self.activate

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/overrides/**/*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      Dir[root + 'lib/liquid/**/*.rb'].each { |f| Rails.env.production? ? require(f) : load(f) }

      %w{. tags drops filters blocks}.each do |dir|
        Dir[File.join(File.dirname(__FILE__), '../../../app/liquid', dir, '*.rb')].each { |lib| Rails.env.production? ? require(lib) : load(lib) }
      end

      ActiveRecord::Base.send(:include, Liquid::ActiveRecord::Droppable)

    end

    config.to_prepare &method(:activate).to_proc

  end
end