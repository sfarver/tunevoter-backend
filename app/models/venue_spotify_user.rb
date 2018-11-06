class VenueSpotifyUser < ApplicationRecord
  belongs_to :spotify_user
  belongs_to :venue
  
  def get_top_artists
    SpotifyUserArtist.all.select{|spotify_user_artist| spotify_user_artist == self}
  end
end