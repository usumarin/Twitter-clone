Rails.application.routes.draw do
  devise_for :users
  root to: 'static_pages#index'
  get '/tweets', to: 'tweets#index'
  get '/new', to: 'tweets#new'
  post '/tweets', to: 'tweets#create'
  resources :relationships, only: [:create, :destroy]
end
