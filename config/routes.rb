Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_user_login'
  end
  root to: 'static_pages#index'
  get '/tweets', to: 'tweets#index'
  post '/tweets', to: 'tweets#create'
  delete 'tweets/:id', to: 'tweets#destroy'
  resources :users, only: [:index, :show, :destroy] do
    member do
      get :following, :followers
    end
  end
  resources :tweets, only: [:create, :show, :destroy] do
    resources :likes, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end
