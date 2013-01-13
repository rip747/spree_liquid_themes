module Refinery
  module Themes
    module Admin
      class ThemesController < ::Refinery::AdminController

        def index
          @themes = Refinery::Themes::Theme.all
        end

        def upload

        end

        def settings

        end

        def select_theme
          ::Refinery::Setting.set(:current_theme, params[:key])
          @themes = Refinery::Themes::Theme.all
          #redirect_to(:controller => 'admin/themes', :action => 'index')
          redirect_to themes_admin_root_url
        end

      end
    end
  end
end
