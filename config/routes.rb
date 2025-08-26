Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check


  # Defines the root path route ("/")
  # root "posts#index"
  resources :conversations, only: [:index, :show, :create, :destroy, :new] do
    post :create_events, on: :member   # ✅ ton bouton "✨ Générer 3 événements" utilisera ça
    resources :messages, only: [:create]
    resources :message_users, only: [:create]
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
