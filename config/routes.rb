Rails.application.routes.draw do
  root 'tasks#index'
  
  # Sessions
  get 'login', to: 'sessions#new', as: :login 
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout
  
  # Regular users
  resources :users, only: [:new, :create, :show, :edit, :update]
  
  # Tasks
  resources :tasks
  
  # Admin namespace
  namespace :admin do
    resources :users
  end
end