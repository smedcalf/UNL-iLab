Ilab::Application.routes.draw do

  resources :events, controller: :calendar do
    collection do
      post 'mark-completed', to: 'calendar#mark_as_completed', as: :complete
      post 'mark-incomplete', to: 'calendar#mark_as_incomplete', as: :incomplete
    end
  end
  resources :instructors do
    resources :preferences, controller: :sponsor_preferences do
      collection do
        post 'student', to: 'sponsor_preferences#student', as: :student
        post 'update', to: 'sponsor_preferences#update_preferences', as: :update
      end
    end
  end

  resources :sessions, only: [:new, :create, :destroy, :index]
  resources :static_pages

  # Messy routes
  resources :projects do
    collection do
      post  'manage-projects', to: 'projects#manage_projects', as: :manage
    end
  end

  resources :requests do
    collection do
      post  'manage-requests', to: 'requests#manage_requests', as: :manage
    end
  end

  resources :solutions

  resources :sponsors do
    resources :preferences, controller: :sponsor_preferences do
      collection do
        post 'student', to: 'sponsor_preferences#student', as: :student
        post 'update', to: 'sponsor_preferences#update_preferences', as: :update
      end
    end
  end

  #TODO this is confusing with student preference as collection
  resources :students do
    resources :preferences, controller: :student_preferences

    collection do
      post  'delete-students', to: 'students#destroy', as: :delete_multiple
    end

    member do
      get   'apply', to: 'students#apply', as: :apply
    end
  end

  resources :teams do

    collection do
      get    'team-assignment', to: 'teams#team_assignment', as: :assignment
      get    'team-works', to: 'teams#team_work', as: :team_work
      post   'track', to: 'teams#team_track', as: :team_track
      post   'add-students', to: 'teams#add_students', as: :add
      post   'delete-teams', to: 'teams#delete_teams', as: :delete_multiple
    end

    member do
      get    'calendar', to: 'calendar#team_calendar', :as => :calendar
      get    'task/new', to: 'calendar#new_team_task', :as => :new_task
      get    'work-track', to: 'teams#work_track', as: :work_track
    end

  end

  resources :users do

    collection do
      post   'manage-users', to: 'users#manage_users', as: :manage
    end

    member do
      get    'change-password', to: 'users#edit', as: :change_password
    end
  end

  # Named Routes
  # Session routes
  get    'register', to: 'users#new'
  get    'login', to: 'sessions#new'
  get    'signout', to: 'sessions#destroy'
  get    'reset-password', to: 'sessions#reset_password'
  post   'sessions/temporary_password', to: 'sessions#temporary_password'

  get    'calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
  post   'calendar/create' => 'calendar#create'
  get    'task/new' => 'calendar#new', :as => :new_calendar
  post   '/sponsor_preferences/preference', to: 'sponsor_preferences#preference'

  get 'student-preferences', to: 'student_preferences#all', as: :all_student_preferences
  get 'sponsor-preferences', to: 'sponsor_preferences#all', as: :all_sponsor_preferences

  post    '/student_preferences/delete-student-preferences', to: 'student_preferences#destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root to: 'sessions#new'

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
