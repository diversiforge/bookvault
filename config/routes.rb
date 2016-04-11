Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :authors
  resources :publishers
  resources :books

  namespace :admin do
    resource :system_config, only: [:edit, :update]
  end

  root to: 'books#index'
end
