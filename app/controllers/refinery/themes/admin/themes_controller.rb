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

          # view_paths reloading hack
          paths = ActionController::Base.view_paths.paths

          paths.each do |path|
            if path.to_s.eql?(Rails.root.join("themes/#{Refinery::Themes::Theme.current_theme_key}/views").to_s)
              paths.delete path
            end
          end

          assets_paths = Rails.application.config.assets.paths

          assets_paths.each do |path|
            if path.eql?(Refinery::Themes::Theme.theme_path.join("assets/javascripts").to_s) ||
                path.eql?(Refinery::Themes::Theme.theme_path.join("assets/stylesheets").to_s) ||
                path.eql?(Refinery::Themes::Theme.theme_path.join("assets/images").to_s)

              assets_paths.delete path
            end
          end

          ::Refinery::Setting.set(:current_theme, params[:key])

          reload_assets_paths

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


        private

        def reload_assets_paths
          ActionController::Base.prepend_view_path  Rails.root.join("themes/#{Refinery::Themes::Theme.current_theme_key}/views")
          Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/javascripts").to_s
          Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/stylesheets").to_s
          Rails.application.config.assets.paths << Refinery::Themes::Theme.theme_path.join("assets/images").to_s
          Rails.application.config.assets.paths.each { |path| Rails.application.assets.append_path(path) }
        end
      end
    end
  end
end
