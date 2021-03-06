Projecto::Application.routes.draw do
	
	get "gallery/:id", to: 'gallery#show', as: :gallery
  post "gallery/:id/upload", to: 'gallery#upload', as: :gallery_upload

  get "project/:id/collaborations", to: 'project_collaboration_info#collaborations', as: :project_collaborations
  get "project/:id/applications", to: 'project_collaboration_info#applications', as: :project_applications
  get "project/:id/invitations", to: 'project_collaboration_info#invitations', as: :project_invitations

  get "users/:id/collaborations", to: 'user_collaboration_info#collaborations', as: :user_collaborations
  get "users/:id/projects", to: 'user_collaboration_info#projects', as: :user_projects

  get "users/:id/applications", to: 'user_request_info#applications', as: :user_applications
  get "users/:id/invitations", to: 'user_request_info#invitations', as: :user_invitations

  resources :messages

  get "landing", to: 'main#landing', as: :landing
  resources :beta_users, only: [:create]

  # You can have the root of your site routed with "root"
  root 'main#index'
  get "about", to: 'main#about', as: :about

  get 'tags/:tag', to: 'projects#index', as: :tag
  get 'category/:cat', to: 'projects#index', as: :cat

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  # USER PROFILES ################

  get "user_profiles/:id/resume", to: 'resume#show', as: :resume
  get "user_profiles/:id/resume/edit", to: 'resume#edit', as: :edit_resume

  resources :user_profiles, only: [:show, :edit, :update]
  resources :resume_entries, only: [:edit,:update,:destroy]
  get "user_profiles/:id/resume_entry/new", to: 'resume_entries#new', as: :new_resume_entry

  # PROJECT PROFILES ########################

  resources :project_profiles, only: [:show, :edit], controller: :project_details
  resources :project_details_entry, only: [:edit,:update,:destroy]
  get "project_profiles/:id/details_entry/new", to: 'project_details_entry#new', as: :new_project_details_entry

  # TASKS and TASK GROUPS ###################################

  resources :tasks, except: [:new, :index]
  resources :task_groups, except: [:new, :index]

  # APPLICATIONS AND INVITATIONS ###########################

  resources :collaboration_invitations, only: [:show, :create, :update]
  resources :collaboration_applications, only: [:show, :create, :update]
  resources :comments, only: [:create]
  resources :news_posts, only: [:create]

  # PROJECTS AND ASSOCIATED ####################################

  resources :projects, shallow: true, except: [:show] do
		resources :comments, except: [:create, :show, :new]
		resources :news_posts, except: [:create, :new]
		resources :collaborations, except: [:show, :new, :create]
		resources :task_groups, only: [:new, :index]
		resources :tasks, only: [:index]
	end

  # USERS AND ASSOCIATED ########################################

  #get "users/:id/show", to: 'users#show', as: :user

	resources :subscriptions, only: [:create, :destroy]
  #get "members", to: "users#index"
	
  resources :users, only: [:index] do
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
