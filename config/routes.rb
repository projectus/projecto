Projecto::Application.routes.draw do

  post "collaboration/project/:project_id/apply", to: "collaboration_application#create", as: :apply_to_project
	post "collaboration/application/:id/accept", to: "collaboration_application#accept", as: :accept_project_application
  post "collaboration/application/:id/deny", to: "collaboration_application#deny", as: :deny_project_application																			
  get "collaboration_application/show/:id", to: 'collaboration_application#show', as: :collaboration_application
  
  get "users", to: "users#index", as: :users
  get "users/show/:id", to: 'users#show', as: :user
	
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :collaborations, :projects

  get "main/home"
  get 'tags/:tag', to: 'projects#index', as: :tag

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index'

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
