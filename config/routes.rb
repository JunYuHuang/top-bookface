Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show] do
    resources :follows, only: [:index, :create, :destroy]
    resources :follow_requests, only: [:index, :create, :destroy]
  end

  resources(
    :posts,
    only: [:index, :show, :create, :new, :update, :edit, :destroy]
  ) do
    resources :comments, only: [:index, :show, :create, :update, :edit, :destroy]
  end

  resources :likes, only: [:create, :destroy]

  root "posts#index"
end
