Rails.application.routes.draw do
  get 'static_pages/home'
  root 'static_pages#home'
  
  get 'profile', to: 'static_pages#profile'
  get 'login', to: 'static_pages#login'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
