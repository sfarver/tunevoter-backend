class Venue < ApplicationRecord
  has_many :spotify_users, through: :venue_spotify_users

  def most_popular_artists(is_weighted)

    users = self.select_venue_users

    venue_artists_hash = {}

    users.each do |user|
      artists = user.get_top_artists

      artists.each do |artist|
        # NOTE: Need to ensure there are 50 artists being pulled each time
        score = is_weighted ? 50 - artist.rank : 1

        if venue_artists_hash[artist]
          venue_artists_hash[artist] += score
        else
          venue_artists_hash[artist] = score
        end
      end
    end

    venue_artists_hash
  end

  private

  def select_venue_users
    VenueSpotifyUser.all.select{|venue_spotify_user| venue_spotify_user.venue == self}
  end
end
