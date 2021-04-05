Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/profile', to: 'users#profile'
  resources :users, only: %i[index show edit update] do
    resources :groups, only: %i[new create]
  end
  resources :groups, only: %i[index show edit update destroy]

end
