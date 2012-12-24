module Refinery
  module Themes
    class Theme < Refinery::Core::BaseModel
      attr_accessible :name, :description, :position

      class << self

        def current_theme
          ::Refinery::Setting.find_or_set(:current_theme, "default")
        end

        def default_layout
          ::Refinery::Setting.find_or_set(:default_layout, "site")
        end

        def current_theme_path
          Rails.root.join("themes/#{Refinery::Themes::Theme.current_theme}")
        end

        def layout_raw(file_name)
          File.read(self.current_theme_path.join("layouts/#{file_name}.liquid"))
        end

        def all
          Dir.glob(File.join(THEME_PATH, "*")).collect { |dir|
            dir = dir.split("/").last
            [config_for(dir)["theme"]["name"], dir]
          }
        end

        def config_for(key)
          YAML::load(File.open(self.current_theme_path.join("config/config.yml")))
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
