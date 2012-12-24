Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :themes do
    resources :themes, :path => '' do

    end
  end

  # Admin routes
  namespace :themes, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :themes, :except => :show do
        collection do
          post :list
          post :file
          post :save_file
          post :add
          post :rename
          post :delete
          post :update_positions
        end
      end
    end
  end

end
