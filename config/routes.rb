Rails.application.routes.draw do
  root 'tasks#index'
  
  # Sessions
  get 'login', to: 'sessions#new', as: :new_session
  post 'login', to: 'sessions#create', as: :create_session
  delete 'logout', to: 'sessions#destroy', as: :destroy_session
  
  # Regular users
  resources :users, only: [:new, :create, :show, :edit, :update]
  
  # Tasks
  resources :tasks
  
  # Admin namespace
  namespace :admin do
    resources :users
  end
end