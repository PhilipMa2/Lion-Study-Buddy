Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root 'home#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  resources :posts do
    member do
      post :apply
      post :close
    end
  end
  post 'posts/:id/accept_application', to: 'posts#accept_application', as: :accept_application
  post 'posts/:id/reject_application', to: 'posts#reject_application', as: :reject_application
  
  get 'profile', to: 'students#profile'
  get 'students/:id', to: 'students#show', as: :student

  resources :time_slots, only: [:create]
end
