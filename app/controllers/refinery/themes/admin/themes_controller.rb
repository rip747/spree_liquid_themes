module Refinery
  module Themes
    module Admin
      class ThemesController < ::Refinery::AdminController

        def index
          @themes = Refinery::Themes::Theme.all
        end

        def upload; end

        def settings; end

        def update

        end

        def reset
          FileUtils.rm_rf(Rails.root.join('themes', 'default')) if File.exist?(Rails.root.join('themes', 'default'))
          FileManager.unzip_file(File.join(SpreefineryThemes::Engine.root, "theme_template", "default.zip"))
          redirect_to themes_admin_root_url, :notice =>"The default theme successfully reset!"
        end

        def select_theme
          ::Refinery::Setting.set(:current_theme, params[:key])
          @themes = Refinery::Themes::Theme.all
          #FileUtils.rm_rf(Rails.root.join('themes/current'))
         # FileUtils.ln_sf(Refinery::Themes::Theme.theme_path, Rails.root.join('themes/current'))

          ActionController::Base.prepend_view_path  Rails.root.join("themes/#{Refinery::Themes::Theme.current_theme_key}/views")
          Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/javascripts")
          Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/stylesheets")
          Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/images")

          #ActionController::Base.view_paths = ActionView::PathSet.new(ActionController::Base.view_paths.paths)
          ::Refinery::Page.expire_page_caching
          #Rails.cache.clear

          redirect_to themes_admin_root_url
        end

        def create
          zipf = params[:zip_file]

          directory = "/tmp/uploads"
          `rm -rf "#{directory}"`
          `mkdir "#{directory}"`

          path = File.join(directory, zipf.original_filename)
          File.open(path, "wb") { |f| f.write(zipf.read) }

          FileManager.unzip_file(path)
          `rm #{path}`

          redirect_to themes_admin_root_url, :notice =>"A new theme was successfully uploaded and installed!"
        end

      end
    end
  end
end
