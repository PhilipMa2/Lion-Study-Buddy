  Rails.application.routes.draw do
    get "up" => "rails/health#show", as: :rails_health_check

    root 'home#index'
    resources :posts, only: [:show, :new, :create]

    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'profile', to: 'students#profile'
  end
