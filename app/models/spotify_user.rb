class SpotifyUser < ApplicationRecord
  has_many :venue_spotify_users
  has_many :spotify_user_artists
  has_many :venues, through: :venue_spotify_users
  has_many :artists, through: :spotify_user_artists
  
  def users_by_date
    self.spotify_users.reduce({}) do |total, user|
      date = user.created_at.to_date
      
      total[date] ? total[date] += 1 : total[date] = 1
      
      total
    end
  end
end
