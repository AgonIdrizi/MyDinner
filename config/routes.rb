Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  root to: 'items#index'
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resource :cart, only: [:show]
  resources :items , only: [:show,:index] do
    resources :reviews, except: [:new]
  end
  resources :line_items, only: [:create, :update, :destroy]
  resources :orders, only: [:show]
  resources :users, only: [:show]
  resource :checkout , only: [:new, :create]
  resource :payment , only: [:new, :create]

  get 'sales', to: 'sales#sales'
  post 'last_order', to: 'orders#last_order'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
