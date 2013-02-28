Ecotunes::Application.routes.draw do
  get "user/user"

  authenticated :user do
    root :to => "musicexplorer#explorer"
  end

  root :to => redirect("/users/sign_in")
  
  devise_for :users

  get "collection" => "collection#collection"
  post "collection" => "collection#collection"
  post "collection/show_result_album"
  post "collection/show_result_parser"

  match "management" => "management#management"
  get "management/duplicatecheck"
  get "management/import"
  get "management/retagging"

  get "users/index", :as => :users

  resources :playlists
  resources :artists
  resources :albums
  resources :songs


  get "playlist_generator/Playlist"

  get "musicexplorer/explorer"
  

  get "musicexplorer/search"

  post "playlists/newsong", :as => :new_song
  post "playlists/removesong", :as => :remove_song
  post "playlists/addalbum"

  get "songs/new", :as => :musicupload

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
