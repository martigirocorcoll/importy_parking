Rails.application.routes.draw do
  resources :cars
  get "select", to: "cars#select", as: :select_cars
  devise_for :users
  root to: 'cars#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
