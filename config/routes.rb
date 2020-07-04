Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'static_pages#index'
  get '/tweets', to: 'tweets#index'
  get '/new', to: 'tweets#new'
  post '/tweets', to: 'tweets#create'
  # get 'users/show', to: 'users#show'
  resources :users, only: [:index, :show]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end
