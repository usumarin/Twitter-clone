Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'static_pages#index'
  get '/tweets', to: 'tweets#index'
  post '/tweets', to: 'tweets#create'
  delete 'tweets/:id', to: 'tweets#destroy'
  resources :users, only: [:index, :show, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end
