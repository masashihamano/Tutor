Rails.application.routes.draw do

  # devise_for :users
  root to: 'pages#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }

  resources :users, only: [:show]

end
