Rails.application.routes.draw do
  match "(*any)", to: redirect(subdomain: ""), via: :all, constraints: {subdomain: "www"}

  resources :games, except: %i[edit destroy]

  get "up" => "rails/health#show", :as => :rails_health_check

  root to: "games#index"
end
