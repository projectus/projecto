Projecto::Application.routes.draw do

  get "project/:id/collaborations", to: 'project_collaboration_info#collaborations', as: :project_collaborations
  get "project/:id/applications", to: 'project_collaboration_info#applications', as: :project_applications
  get "project/:id/invitations", to: 'project_collaboration_info#invitations', as: :project_invitations

  get "users/:id/collaborations", to: 'user_collaboration_info#collaborations', as: :user_collaborations
  get "users/:id/projects", to: 'user_collaboration_info#projects', as: :user_projects

  get "users/:id/applications", to: 'user_request_info#applications', as: :user_applications
  get "users/:id/invitations", to: 'user_request_info#invitations', as: :user_invitations

  resources :messages

  # You can have the root of your site routed with "root"
  root 'main#index'
  get "about", to: 'main#about', as: :about

  get 'tags/:tag', to: 'projects#index', as: :tag
  get 'category/:cat', to: 'projects#index', as: :cat
	
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # USER PROFILES ################

  #get "profile/:id", to: "user_profiles#show"
  get "user_profiles/:id/resume", to: 'user_profiles#show_resume', as: :resume
  resources :user_profiles, except: [:index, :new, :create, :destroy]

  # PROJECT PROFILES ########################

  resources :project_profiles, except: [:index, :new, :create]
  get "project_profiles/:id/details", to: 'project_profiles#details', as: :project_details
  get "project_profiles/:id/new", to: 'project_profiles#new', as:  :new_project_details

  # TASKS and TASK GROUPS ###################################

  resources :tasks, except: [:new, :index]
  resources :task_groups, except: [:new, :index]

  # APPLICATIONS AND INVITATIONS ###########################

  resources :collaboration_invitations, except: [:index, :new, :destroy, :edit]
  resources :collaboration_applications, except: [:index, :new, :destroy, :edit]
  resources :comments, only: [:create]
  resources :news_posts, only: [:create]

  # PROJECTS AND ASSOCIATED ####################################

  resources :projects, shallow: true do
		resources :collaboration_applications, only: [:new]
		resources :comments, except: [:create, :show, :new]
		resources :news_posts, except: [:create, :new]
		resources :collaborations, except: [:show, :new, :create]
		resources :task_groups, only: [:new, :index] 
	end

  # USERS AND ASSOCIATED ########################################

  #get "users/:id/show", to: 'users#show', as: :user

	resources :subscriptions, only: [:create, :destroy]
  #get "members", to: "users#index"
	
  resources :users, only: [:index] do
	  resources :collaboration_invitations, only: [:new]
		resources :subscriptions, only: [:index]  
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
