Rails.application.routes.draw do
  get 'static_pages/home'
  root 'static_pages#home'
  
  get 'login', to: 'static_pages#login'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get '/:vid', to: 'users#show'
  get 'users/show'
  get 'users/index', as: 'users'

  resources :posts, only: [:create, :destroy]
  resources :users, only: [:update]
end
