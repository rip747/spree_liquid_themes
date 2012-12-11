module Refinery
  module Themes
    class ThemesController < ::ApplicationController

      before_filter :find_all_themes
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @theme in the line below:
        present(@page)
      end

      def show
        @theme = Theme.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @theme in the line below:
        present(@page)
      end

    protected

      def find_all_themes
        @themes = Theme.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/themes").first
      end

    end
  end
end
