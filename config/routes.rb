Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post '/login', to: 'auth#create'

      resources :spotify_users, only: [:create]
      resources :venues, only: [:create]
      get '/top_artists', to: 'venues#top_artists'
      get '/top_genres', to: 'venues#top_genres'
    end
  end
end
