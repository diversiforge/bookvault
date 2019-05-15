Rails.application.routes.draw do
  devise_for :users
  resources :authors
  resources :publishers
  resources :books do
    post :search, on: :collection
    post :export, on: :collection
    post :update_from_open_library, on: :member
  end

  get '/search', to: 'search#index'
  get '/search/barcode', to: 'search#barcode'
  get '/search/title', to: 'search#title'
  post '/search/by_barcode', to: 'search#by_barcode'
  post '/search/by_title', to: 'search#by_title'

  namespace :admin do
    resource :system_config, only: [:edit, :update]
    resources :users
  end

  root to: 'books#index'
end
