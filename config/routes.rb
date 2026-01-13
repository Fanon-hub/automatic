Rails.application.routes.draw do
  root 'tasks#index'

  resources :tasks
  resources :labels, only: [:index, :new, :create, :edit, :update, :destroy], path_names: { new: 'new_label', edit: 'edit_label' }
  resource :account, only: [:show, :edit, :update], controller: 'users'

  # Login / Logout
  get    '/login',   to: 'sessions#new',     as: :new_session
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy', as: :logout 

  # User registration & account
  resources :users, only: [:new, :create]
  resource :user, only: [:show, :edit, :update]

  # Admin namespace
  namespace :admin do
    resources :users
  end

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end