Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'

  resources :books
  resources :rentals, :only => [:index, :new, :create]
  resources :users, :only => [:index, :edit, :update]
  resources :logs

  get 'search_book', to: 'rentals#search_book', path: "/rentals/new/search_book"
  get 'get_info', to: 'books#get_info', path: "/books/new/get_info"
  get 'return', to: 'rentals#pre_return', path: "/rentals/return"
  get 'search_book', to: 'rentals#search_book', path: "/rentals/return/search_book"
  post 'rentals', to: 'rentals#post_return', path: "/rentals/return"

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
