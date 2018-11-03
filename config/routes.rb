Rails.application.routes.draw do
  resources :spotify_users, only: [:create]
end
