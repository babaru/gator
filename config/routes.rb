Rails.application.routes.draw do

  
  
  post 'trustors/search' => 'trustors#index', as: :search_trustors
  post 'users/search' => 'users#index', as: :search_users
  post 'consultants/search' => 'consultants#index', as: :search_consultants
  post 'securities_brokers/search' => 'securities_brokers#index', as: :search_securities_brokers
  post 'departments/search' => 'departments#index', as: :search_departments
  post 'banks/search' => 'banks#index', as: :search_banks
  post 'products/search' => 'products#index', as: :search_products
  
  
  
  
  
  

  devise_for :users
  root 'products#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  post 'clients/search' => 'clients#index', as: :search_clients
  get 'clients/upload_original_document' => 'clients#upload_original_document', as: :upload_client_original_document

  

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  get 'trustors/banck_accounts' => 'trustors#bank_accounts'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :products, :departments, :clients, :consultants,
    :product_managers, :trustors, :banks, :securities_brokers, :users

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
