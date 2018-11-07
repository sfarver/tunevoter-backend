class Venue < ApplicationRecord
  has_secure_password
  has_many :venue_spotify_users
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

        if venue_artists_hash[artist.artist.name]
          venue_artists_hash[artist.artist.name] += score
        else
          venue_artists_hash[artist.artist.name] = score
        end
      end
    end
    
    venue_artists_hash
  end
  
  def most_popular_genres(is_weighted)
    artists = most_popular_artists(is_weighted)
        
    venue_genres_hash = {}
    
    artists.each do |artist_name, score|
      artist = Artist.find_by(name: artist_name)
      
      artist.genres.each do |genre|
        if venue_genres_hash[genre.name]
          venue_genres_hash[genre.name] += score
        else
          venue_genres_hash[genre.name] = score
        end
      end      
    end
    
    venue_genres_hash
  end
end
