require 'open-uri'

module Refinery
  module Themes
    class Theme < Refinery::Core::BaseModel

      attr_accessible :name, :description, :position

      def default_assigns(str)
        yaml = YAML::load(str)["assigns"] || false
        return {} unless yaml
        assigns = extract_assigns(yaml, :vars)
        extract_assigns(yaml, :collections).each do |k, v|
          assigns[k] = Collection.find_by_key v
        end
        return assigns
      end


      class << self
        include ActionController::DataStreaming

        attr_accessor :content_type, :headers

        def current_theme
          ::Refinery::Setting.find_or_set(:current_theme, "default")
        end

        def default_layout
          ::Refinery::Setting.find_or_set(:default_layout, "site")
        end

        def current_theme_path(theme_dir=Refinery::Themes::Theme.current_theme)
          Rails.root.join("themes/#{theme_dir}")
        end

        def layout_raw(file_name)
          File.read(self.current_theme_path.join("layouts/#{file_name}.liquid"))
        end

        def all
          Dir.glob(Rails.root.join("themes", "*")).collect { |dir|
            dir = dir.split("/").last
            config = config_for(dir)
            config["theme"]
          }
        end

        def config_for(key)
          YAML::load(File.open(self.current_theme_path(key).join("config/config.yml")))
        end

        def layouts
          layouts_list(self.current_theme_path.join("views/layouts", "*.liquid"))
        end

        def templates
          templates_list(self.current_theme_path.join("views/refinery/pages/", "*.liquid"))
        end

        private

        def layouts_list(path)
          Dir.glob(path).collect { |file|
            file.split("/").last.gsub(/.liquid/, "")
          }
        end

        def templates_list(path)
          Dir.glob(path).collect { |file|
            file.split("/").last.gsub(/.liquid/, "")
          }
        end
      end
    end
  end
end
