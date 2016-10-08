Rails.application.routes.draw do

  post 'product_diffs/search' => 'product_diffs#index', as: :search_product_diffs
  post 'query_consultants' => 'consultants#search', as: :query_consultants
  post 'query_departments' => 'departments#search', as: :query_departments
  post 'query_products' => 'products#search', as: :query_products
  post 'query_staffs' => 'staffs#search', as: :query_staffs
  post 'query_users' => 'users#search', as: :query_users
  post 'query_clients' => 'clients#search', as: :query_clients

  match 'products/import' => 'products#import_from_excel', as: :import_products, via: [:post, :get]

  post 'users/upgrade_to_product_manager/:id' =>'users#upgrade_to_product_manager', as: :upgrade_to_product_manager

  devise_for :users
  root 'products#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  get 'clients/upload_original_document' => 'clients#upload_original_document', as: :upload_client_original_document

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  get 'trustors/banck_accounts' => 'trustors#bank_accounts'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :products, :departments, :clients, :consultants, :users, :staffs, :product_shares, :product_diffs

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
