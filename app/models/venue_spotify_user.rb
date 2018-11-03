class VenueSpotifyUser < ApplicationRecord
  belongs_to :spotify_user
  belongs_to :venue
end