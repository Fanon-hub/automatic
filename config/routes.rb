Rails.application.routes.draw do
  root 'tasks#index'

  resources :tasks

  # Login / Logout
  get    '/login',   to: 'sessions#new',     as: :login 
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy', as: :logout 

  # User registration & account
  resources :users, only: [:new, :create]
  resource :user, only: [:show, :edit, :update]

  # Admin namespace
  namespace :admin do
    resources :users
  end
end