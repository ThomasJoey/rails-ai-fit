Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :conversations, only: [:index, :show, :create, :destroy] do
    post :create_events, on: :member   # ✅ ton bouton "✨ Générer 3 événements" utilisera ça
    resources :messages, only: [:create]
  end

  resources :events, only: [:index, :new, :create, :show, :destroy] do
    post :confirm, on: :member
    resources :event_participations, only: [:new, :create, :destroy]
  end

  resource :profile, only: :show

  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
