Chienowa::Application.routes.draw do

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :items

  root 'items#home'
  match '/search', to: 'items#search', via: 'get'
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via:'delete'

  match '/home', to: 'items#home', via: 'get'
  match '/help', to: 'items#help', via: 'get'
  match '/contact', to: 'items#contact', via: 'get'
  match '/item_histories/:id', to: 'item_histories#index', via: 'get', as: :item_histories

  match '/item_comments', to: 'item_comments#create', via: 'post'
  match '/item/preview', to: 'items#preview', via: 'post'

  scope ':user' do
    match '/items/:id', to: 'items#show', via: 'get', as: 'user_item'
  end

  match '/stars', to: 'stars#create', via: 'post'
  match '/stars', to: 'stars#destroy', via: 'delete'
  match '/stars/:site_id/:item_id', to: 'stars#list', via: 'get'

 # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
