Rails.application.routes.draw do
  root to: 'static_pages#index'
  get '/tweets', to: 'tweets#index'
end
