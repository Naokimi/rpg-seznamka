Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, only: %i[show edit update] do
      resources :groups, only: [:index]
  end
end
