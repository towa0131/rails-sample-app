Rails.application.routes.draw do
  get 'static_pages/home'
  root 'static_pages#home'
  
  get 'login', to: 'static_pages#login'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get '/:vid', to: 'users#show'
  get '/:vid/followers', to: 'users#show_followers'
  get '/:vid/followings', to: 'users#show_followings'
  get 'users/show'
  get 'users/index', as: 'users'

  post "/posts/reply"
  

  resources :posts, only: [:create, :destroy, :show]
  resources :users, only: [:update]
  resources :follow_relationships, only: [:create, :destroy]
end
