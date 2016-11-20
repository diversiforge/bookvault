Rails.application.routes.draw do
  devise_for :users
  resources :authors
  resources :publishers
  resources :books do
    post :search, on: :collection
    post :export, on: :collection
  end

  namespace :admin do
    resource :system_config, only: [:edit, :update]
    resources :users
  end

  # public controllers
  namespace :stacks do
    resources :books, only: [:index, :show] do
      post :search, on: :collection
    end
    resource :browse, controller: 'browse', only: :show do
      get :by_tag
    end
  end

  root to: 'books#index'
end
