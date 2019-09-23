Rails.application.routes.draw do
  
  get 'pay_pal_payments/approved'
  get 'review_replies/create'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  root to: 'items#index'
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resource :cart, only: [:show, :destroy]
  resources :items , only: [:show,:index] do
    resources :reviews, except: [:new]
  end
  resources :line_items, only: [:create, :update, :destroy]
  resources :orders, only: [:show]
  resources :users, only: [:show]
  resource :checkout , only: [:new, :create]
  resource :payment , only: [:new, :create]
  resources :recommendation, only: [:create]
  resources :review_replies, only: [:create]
  resources :restaurants, only: [:index]
  get 'sales', to: 'sales#sales'
  post 'last_order', to: 'orders#last_order'
  get 'recommendations', to: 'recommendations#index'
  get 'welcome', to: 'welcomes#welcome'
  get 'about', to: 'staticpages#about'
  get 'contact', to: 'staticpages#contact'
  get 'paypal/approved', to: 'pay_pal_payments#approved'
  get '/:name', to: 'restaurants#agon', constraints: lambda { |req| Restaurant.all.pluck(:name).include?(req.params[:name]) } 


  class DateFormatConstraint
    def self.matches?(request)
    request.params[:name] == "Agon's house"  # YYYY-MM-DD
    end
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
