class VenueSpotifyUser < ApplicationRecord
  belongs_to :spotify_user
  belongs_to :venue
  
  def get_top_artists
    SpotifyUserArtist.all.select do |spotify_user_artist|   
      spotify_user_artist.spotify_user_id == self.spotify_user_id
    end
  end
end