Rails.application.routes.draw do
  devise_for :users
  resources :authors
  resources :publishers
  resources :books do
    post :search, on: :collection
  end

  namespace :admin do
    resource :system_config, only: [:edit, :update]
    resources :users
  end

  root to: 'books#index'
end
