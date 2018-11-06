class SpotifyUser < ApplicationRecord
  has_many :venues, through: :venue_spotify_users
  has_many :artists, through: :spotify_user_artists
end
