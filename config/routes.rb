Ilab::Application.routes.draw do

  get "sponsor_preferences/index"
  get "sponsor_preferences/new"
  get "sponsor_preferences/show"
  get "student_preferences/index"
  get "sponsor_preferences/application/:id" => "sponsor_preferences#application", :as => :application_sponsor_preference
  get "student_preferences/new/:id" => "student_preferences#new", :as => :new_student_preference
  get "student_preferences/edit/:id" => "student_preferences#edit", :as => :edit_student_preference
  get "student_preferences/show/:id" => "student_preferences#show", :as => :show_student_preference
  get "preferences/student_preferences"
  get "preferences/sponsor_preferences"
  resources :instructors
  resources :projects
  resources :sessions, only: [:new, :create, :destroy, :index]
  resources :static_pages
  resources :sponsors
  resources :students
  resources :student_preferences
  resources :teams
  resources :users

  # Named Routes
  get 'register', to: 'users#new'
  get 'login', to: 'sessions#new'
  get 'signout', to: 'sessions#destroy'
  post 'teams/add_students', to: 'teams#add_students'
  post 'teams/delete_teams', to: 'teams#delete_teams'
  post 'projects/manage_projects', to: 'projects#manage_projects'
  post 'users/manage_users', to: 'users#manage_users'
  get 'sponsors/preference/:id' => 'sponsors#preference', :as => :preference_sponsor
  get 'students/apply/:id' => 'students#apply', :as => :apply_student
  get 'user/edit_profile/:id' => 'users#edit_profile', :as => :edit_profile_user

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
