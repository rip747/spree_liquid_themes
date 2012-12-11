module Refinery
  module Themes
    module Admin
      class ThemesController < ::Refinery::AdminController

        crudify :'refinery/themes/theme', :title_attribute => 'name', :xhr_paging => true

        def list
          @parent = params[:fullpath]
          file_manager = FileManager.new(Rails.root.join("themes/#{@parent}"), @parent)
          render :json => file_manager.dirs.concat(file_manager.files), :layout => false
        end


        def file
          @file = Rails.root.join("themes/#{params[:fullpath]}")
          render :text => 'file not found' and return unless File.exist? @file
          @content = File.read(@file)
          @content_type = Editable.content_type @file

          if @content_type == 'image'
            render :inline => "<%= image_tag '/themes/#{params[:fullpath]}' %>"
          else
            render :layout => false
          end
        end

        def save_file
          @file = params[:file_name]
          @content = FileManager.save_file(params[:file_name], params[:file_content])
          render :template => 'refinery/themes/admin/themes/file.html.erb', :layout => false
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
