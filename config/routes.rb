Rails.application.routes.prepend  do
  match "/themes/:key/image.png", :to => "refinery/themes/theme#sreenshot"
end

Refinery::Core::Engine.routes.prepend do
  # Admin routes
  namespace :themes, :path => '' do
    namespace :admin, :path => 'refinery' do
      scope :path => 'themes' do
        root :to => "themes#index"

        resource :editor, :controller => 'editor' do
          root :to => "editor#index"

          collection do
            post :list
            post :file
            post :save_file
            post :add
            post :rename
            post :delete
          end
        end

      end


      resources :themes, :except => [:show, :destroy] do
        collection do
          get :upload
          get :settings
          get :select_theme
        end
      end

    end
  end

end
