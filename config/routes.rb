Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'pages#home'

  get '/profile', to: 'users#profile'
  resources :users, only: %i[index show edit update] do
    resources :groups, only: %i[new create]
  end
  resources :groups, only: %i[index show edit update destroy]

  post '/api/repo_update', to: 'api/repo_updates#create'
end
