Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :spotify_users, only: [:create]
    end 
  end
end
