module Refinery
  module Themes
    class ThemesController < ::ApplicationController

      caches_page :image, :javascript, :stylesheet

      def image
        render_theme_item(@theme.image(params[:file_path]), params[:format])
      end

      def javascript
        render_theme_item(@theme.javascript(params[:file_path]), params[:format])
      end

      def stylesheet
        render_theme_item(@theme.stylesheet(params[:file_path]), params[:format])
      end

      private

      def build_theme
        @theme ||= Theme.new params[:theme_id]
      end

      def render_theme_item(file_path, format)
        if File.exists?("#{file_path}.#{format}")
          file_type = Mime::Type.lookup_by_extension(File.extname("#{file_path}.#{format}")[1..-1])
          #send_data "#{file_path}.#{format}", :type => file_type, :disposition => "inline", :stream => false
          send_data IO.read("#{file_path}.#{format}"), :type => file_type, :disposition => "inline", :stream => false
        else
          render :text => "Not Found", :status => 404
        end
      end

    end
  end
end
