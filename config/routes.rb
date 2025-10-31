Rails.application.routes.draw do
  root 'tasks#index'
  get 'tasks/index'
  get 'tasks/show'
  get 'tasks/new'
  get 'tasks/edit'
  get 'tasks/create'
  get 'tasks/update'
  get 'tasks/destroy'
  resources :tasks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
