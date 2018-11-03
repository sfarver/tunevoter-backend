class SpotifyUser < ApplicationRecord
  has_many :venues, through: :venue_spotify_users
end