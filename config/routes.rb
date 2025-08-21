Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :conversations, only: [:index, :new, :show, :create, :destroy] do
    resources :messages, only: [:create, :show]
  end

  resources :events, only: [:new, :create, :show] do
    post :confirm, on: :member
    resources :event_participations, only: [:new, :create]
  end
end
