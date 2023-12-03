Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root 'home#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  resources :groups do
    member do
      post :apply
      post :close
    end
  end
  post 'groups/:id/accept_application', to: 'groups#accept_application', as: :accept_application
  post 'groups/:id/reject_application', to: 'groups#reject_application', as: :reject_application  
  
  resources :students
  get 'profile', to: 'students#profile'

  get 'create-account', to: 'sessions#create_account', as: :create_account
  post 'create-account', to: 'students#create_account', as: :new_account

  resources :time_slots, only: [:create]
end
