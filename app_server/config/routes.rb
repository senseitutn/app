Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  get 'admin/index'

  get 'welcome/index'

  resources :videos

  resources :users

 namespace :api, defaults: { format: 'json'} do
    namespace :v1 do
      # resources :users do
      #   resources :videos
      resources :users
    end
  end

  #### Rutas de VideosController

  # Rutas REST
  post '/api/v1/videos', to: "api/v1/videos#create"

  get '/api/v1/videos', to: "api/v1/videos#index"

  get '/api/v1/videos/get-by-id/:id', to: "api/v1/videos#show"  

  put '/api/v1/videos/:id', to: "api/v1/videos#update"

  delete '/api/v1/videos/:id', to: "api/v1/videos#destroy"

  # Rutas métodos customizados
  get 'api/v1/videos/search/:text', to: "api/v1/videos#search_all"

  get 'api/v1/videos/get-most-populars/', to: "api/v1/videos#get_most_populars"

  get 'api/v1/videos/get-recents/', to: "api/v1/videos#get_recents"

  post 'api/v1/videos/create_from_link', to: "api/v1/videos#create_from_link"


  #### Sprint 3

  get 'api/v1/users/get/:id_facebook', to: "api/v1/users#get_user"

  get 'api/v1/users/get_videos/:id_facebook', to: "api/v1/users#get_videos"

  get 'api/v1/favourites/get-with-user/:id_facebook', to: "api/v1/favourites#get_all_with_user"

  get 'api/v1/favourites/get-with-video/:video_id', to: "api/v1/favourites#get_all_with_video"

  get 'api/v1/histories/get-by-user/:id_facebook', to: "api/v1/histories#get_by_user"

  get 'api/v1/histories/get-by-video/:video_id', to: "api/v1/histories#get_by_video"

  post 'api/v1/histories/create', to: "api/v1/histories#create"
  
  # sprint 4

  post 'api/v1/favourites', to: "api/v1/favourites#create"

  #Este es el de prueba que anda, pero despues lo tengo que borrar
  get 'api/v1/users/favourites/:id_facebook', to: "api/v1/users#favourites"

  get 'api/v1/histories/get-all-ordered-by-date', to: "api/v1/histories#get_all_ordered_by_date"

  get 'api/v1/histories/get-by-user-ordered-by-date/:id_facebook', to: "api/v1/histories#get_by_user_ordered_by_date"

  post 'api/v1/users/create-video', to: "api/v1/users#create_video"

  # Admin panel
  get 'admin', to: "admin#index"

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
