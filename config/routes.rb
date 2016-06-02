Rails.application.routes.draw do
  resources :episodes
  resource :subscription
  root to: 'episodes#index'
  devise_for :users
  resources :users
end
