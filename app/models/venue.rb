class Venue < ApplicationRecord
  has_many :spotify_users, through: :venue_spotify_users
end