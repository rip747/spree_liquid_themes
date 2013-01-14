module Refinery
  module Themes
    class ThemeController < ::ApplicationController

      def sreenshot
        send_data IO.read(File.join(Refinery::Themes::Theme.theme_path(params[:key]), "config/image.png")),
                  :disposition => "inline", :stream => false
      end

    end
  end
end