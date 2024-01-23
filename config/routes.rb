Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :users, only: [:index, :show] do
    resources :follows, only: [:index, :create, :destroy]
    resources :follow_requests, only: [:index, :create, :destroy]
  end

  root "users#index"
end
