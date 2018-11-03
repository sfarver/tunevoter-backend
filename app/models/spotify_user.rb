class SpotifyUser < ApplicationRecord
  has_many :venues, through: :venue_spotify_users
  has_many :artists, through: :spotify_user_artists

  def get_top_artists
    SpotifyUserArtist.all.select{|spotify_user_artist| spotify_user_artist.user == self}
  end
end
