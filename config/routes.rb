Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :items , only: [:show,:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
