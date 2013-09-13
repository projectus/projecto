Projecto::Application.routes.draw do

  get "project/:id/collaborations", to: 'project_collaboration_info#collaborations', as: :project_collaborations
  get "project/:id/applications", to: 'project_collaboration_info#applications', as: :project_applications
  get "project/:id/invitations", to: 'project_collaboration_info#invitations', as: :project_invitations

  get "users/:id/collaborations", to: 'user_collaboration_info#collaborations', as: :user_collaborations
  get "users/:id/applications", to: 'user_collaboration_info#applications', as: :user_collaboration_applications
  get "users/:id/invitations", to: 'user_collaboration_info#invitations', as: :user_collaboration_invitations
  get "users/:id/projects", to: 'user_collaboration_info#projects', as: :user_projects

  resources :messages

  # You can have the root of your site routed with "root"
  root 'main#index'

  get "main/home"
  get 'tags/:tag', to: 'projects#index', as: :tag
  get 'category/:cat', to: 'projects#index', as: :cat
  
  #get "users", to: "users#index", as: :users
  get "users/:id/show", to: 'users#show', as: :user
  get "users/:id/collaboration_info", to: 'users#collaboration_info', as: :user_collaboration_info
	
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # USER PROFILES ################

  get "user_profiles/:id/resume", to: 'user_profiles#show_resume', as: :resume
  resources :user_profiles, except: [:index, :new, :create, :destroy]

  # PROJECT PROFILES ########################

  resources :project_profiles, except: [:index, :new, :create, :destroy]
  get "project_profiles/:id/about", to: 'project_profiles#about', as: :project_about

  # TASKS and TASK GROUPS ###################

  resources :tasks, except: [:new, :index]
	resources :task_groups, only: [:create] 	   
  resources :task_groups, except: [:create, :new, :index] do
	  resources :tasks, only: [:new, :index]
	end

  resources :collaboration_invitations, except: [:index, :new, :destroy, :edit]
  resources :collaboration_applications, except: [:index, :new, :destroy, :edit]
  resources :comments, only: [:create]
  resources :news_posts, only: [:create]

  resources :projects, shallow: true do
		resources :collaboration_applications, only: [:new]
		resources :comments, except: [:create, :show, :new]
		resources :news_posts, except: [:create]
		resources :collaborations, except: [:new, :create]
		resources :task_groups, only: [:new, :index]    
	end

  resources :users, only: [:index] do
	  resources :collaboration_invitations, only: [:new]
	end
	
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
