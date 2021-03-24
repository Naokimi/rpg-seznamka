Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :groups
  resources :users, only: %i[show edit update]
end
