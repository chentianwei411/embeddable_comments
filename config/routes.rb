require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :announcements
      resources :notifications
      resources :services

      root to: "users#index"
    end
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  namespace :api do
    namespace :v1 do
      resources :discussions
    end
  end

  resources :discussions do
    resources :comments
  end

  get :search, controller: :home
  # get :root, controller: :home
  resources :movies
  resources :directors

  root to: 'home#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
