Rails.application.routes.draw do
  resources :episodes
  resource :subscription
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
