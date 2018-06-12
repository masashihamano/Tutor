Rails.application.routes.draw do

  resources :sharings

  root to: 'pages#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }

  resources :users, only: [:show]

  resources :photos, only: [:create, :destroy] do
    collection do
      get :list
    end
  end

  get 'manage-sharing/:id/basics', to: 'sharings#basics', as: 'manage_sharing_basics'
  get 'manage-sharing/:id/description', to: 'sharings#description', as: 'manage_sharing_description'
  get 'manage-sharing/:id/address', to: 'sharings#address', as: 'manage_sharing_address'
  get 'manage-sharing/:id/price', to: 'sharings#price', as: 'manage_sharing_price'
  get 'manage-sharing/:id/photos', to: 'sharings#photos', as: 'manage_sharing_photos'
  get 'manage-sharing/:id/calendar', to: 'sharings#calendar', as: 'manage_sharing_calendar'
  get 'manage-sharing/:id/bankaccount', to: 'sharings#bankaccount', as: 'manage_sharing_bankaccount'
  get 'manage-sharing/:id/publish', to: 'sharings#publish', as: 'manage_sharing_publish'
end
