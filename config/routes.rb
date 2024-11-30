Rails.application.routes.draw do
  get  "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  get  "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  match "(*any)", to: redirect(subdomain: ""), via: :all, constraints: {subdomain: "www"}

  resources :games, except: %i[edit destroy]

  get "up" => "rails/health#show", :as => :rails_health_check

  root to: "games#index"
end
