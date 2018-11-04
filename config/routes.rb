Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post '/login', to: 'auth#create'

      resources :spotify_users, only: [:create]
      resources :venues, only: [:create]
      get '/top_artists', to: 'artists#top_artists'
    end
  end
end
