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
          FileUtils.rm_rf(Rails.root.join('themes/current'))
          FileUtils.ln_sf(Refinery::Themes::Theme.theme_path, Rails.root.join('themes/current'))

          ::Refinery::Page.expire_page_caching
          #Rails.cache.clear


          # TODO remove this hack for update current layout file.
          file = File.read(Rails.root.join('themes/current/views/layouts/site.liquid'))
          File.open(Rails.root.join('themes/current/views/layouts/site.liquid'), 'w+b'){|f| f.write(file)}

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
