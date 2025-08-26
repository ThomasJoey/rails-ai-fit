Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  namespace :api do
    get 'reverse_geocode', to: 'geocoding#reverse'
  end

  # Conversations et messages
  resources :conversations, only: [:index, :show, :create, :destroy] do
    post :create_events, on: :member
    resources :messages, only: [:create]
  end

  # Events avec participations
  resources :events, only: [:index, :new, :create, :show, :destroy] do
    post :confirm, on: :member
    resources :event_participations, only: [:new, :create, :destroy]
  end

  # Profile avec gestion de l'avatar
  resource :profile, only: [:show, :edit, :update] do
    member do
      delete :delete_avatar
    end
  end
end
