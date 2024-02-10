Rails.application.routes.draw do
  get  "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  get  "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  resources :sessions, only: %i[index show destroy]
  resource  :password, only: %i[edit update]
  namespace :identity do
    resource :email,              only: %i[edit update]
    resource :email_verification, only: %i[show create]
    resource :password_reset,     only: %i[new edit create update]
  end

  match "(*any)", to: redirect(subdomain: ""), via: :all, constraints: {subdomain: "www"}

  resources :games, except: %i[edit destroy]

  get "up" => "rails/health#show", :as => :rails_health_check

  root to: "games#index"
end
