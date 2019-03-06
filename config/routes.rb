Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  root to: 'items#index'
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resource :cart, only: [:show]
  resources :items , only: [:show,:index]
  resources :line_items, only: [:create, :update, :destroy]
  resources :orders, only: [:show]
  resources :users, only: [:show]
  resource :checkout , only: [:new, :create]
  resource :payment , only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
