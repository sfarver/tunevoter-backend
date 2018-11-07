class Venue < ApplicationRecord
  has_secure_password
  has_many :spotify_users, through: :venue_spotify_users
  validates :email, uniqueness: { case_sensitive: false }

  def Venue.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

  def most_popular_artists(is_weighted)

    users = VenueSpotifyUser.all.select{|venue_spotify_user| venue_spotify_user.venue == self}

    venue_artists_hash = {}

    users.each do |user|
      artists = user.get_top_artists

      artists.each do |artist|
        score = is_weighted ? 50 - artist.rank : 1

        if venue_artists_hash[artist.display_name]
          venue_artists_hash[artist.display_name] += score
        else
          venue_artists_hash[artist.display_name] = score
        end
      end
    end
    
    venue_artists_hash
  end
end
