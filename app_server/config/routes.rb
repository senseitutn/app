Rails.application.routes.draw do
  get 'welcome/index'

  resources :videos

  resources :users

 namespace :api, defaults: { format: 'json'} do
    namespace :v1 do
      # resources :users do
      #   resources :videos
      resources :users
      resources :videos
      # end
    end
  end

  get 'api/v1/users/get/:id_facebook', to: "api/v1/users#get_user"

  get 'api/v1/users/get_videos/:id_facebook', to: "api/v1/users#get_videos"

   get 'api/v1/videos/search/:text', to: "api/v1/videos#search_all"

  get 'api/v1/favourites/get-with-user/:id_facebook', to: "api/v1/favourites#get_all_with_user"

  get 'api/v1/favourites/get-with-video/:video_id', to: "api/v1/favourites#get_all_with_video"

  get 'api/v1/histories/get-by-user/:id_facebook', to: "api/v1/histories#get_by_user"

  get 'api/v1/histories/get-by-video/:video_id', to: "api/v1/histories#get_by_video"

  post 'api/v1/histories', to: "api/v1/histories#create"
  
  post 'api/v1/favourites', to: "api/v1/favourites#create"

  #Este es el de prueba que anda, pero despues lo tengo que borrar
  get 'api/v1/users/favourites/:id_facebook', to: "api/v1/users#favourites"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
