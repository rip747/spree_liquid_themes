module Refinery
  module Themes
    module Admin
      class EditorController < ::Refinery::AdminController

        def index; end

        def list
          @parent = params[:fullpath]
          file_manager = FileManager.new(Rails.root.join("themes/#{Refinery::Themes::Theme.current_theme}/#{@parent}"), @parent)
          render :json => file_manager.dirs.concat(file_manager.files), :layout => false
        end

        def file
          @related_path = params[:fullpath]
          file = File.join(Rails.root, "themes", Refinery::Themes::Theme.current_theme, params[:fullpath])
          render :text => 'file not found' and return unless File.exist? file
          @content = File.read(file)
          @content_type = Editable.mime_for file

          if @mime_for == 'image'
            render :inline => "<%= image_tag '/themes/#{Refinery::Themes::Theme.current_theme}/#{params[:fullpath]}' %>"
          else
            render :layout => false
          end
        end

        def save_file
          @related_path = params[:file_name]
          @content = FileManager.save_file(@related_path, params[:file_content])
          @content_type = Editable.mime_for @related_path
          render :template => 'refinery/themes/admin/editor/file.html.erb', :layout => false
        end

        def add
          render(:json => FileManager.create_dir(params[:fullpath], params[:title]), :layout => false) if params[:type].eql?('folder')
          render(:json => FileManager.create_file(params[:fullpath], params[:title]), :layout => false) if params[:type].eql?('default')
        end

        def rename
          render(:json => FileManager.rename_dir(params[:fullpath], params[:new_name]), :layout => false) if params[:type].eql?('folder')
          render(:json => FileManager.rename_file(params[:fullpath], params[:new_name]), :layout => false) if params[:type].eql?('default')
        end

        def delete
          render(:json => FileManager.remove_dir(params[:fullpath]), :layout => false) if params[:type].eql?('folder')
          render(:json => FileManager.remove_file(params[:fullpath]), :layout => false) if params[:type].eql?('default')
        end

      end
    end
  end
end
