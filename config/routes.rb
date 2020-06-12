Rails.application.routes.draw do
  root to: 'static_pages#index'
  get '/tweets', to: 'tweets#index'
  get '/new', to: 'tweets#new'
  post '/tweets', to: 'tweets#create'
end
