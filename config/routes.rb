Rails.application.routes.draw do
  resources :games

  get "up" => "rails/health#show", as: :rails_health_check

  root to: "games#index"
end
