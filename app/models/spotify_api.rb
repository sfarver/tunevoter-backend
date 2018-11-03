class SpotifyApi
  def self.get_all_spotify_info(access_token, venue)
    self.get_user_info(access_token, venue)
  end
  
  # def get_similar_artists(spotify_artist_id)
  #   url = 'https://api.spotify.com/v1/me'
  # end

  private

  def self.get_user_info(access_token, venue)
    url = 'https://api.spotify.com/v1/me'

    api_data = RestClient.get(url, headers={'Authorization': 'Bearer ' + access_token})
    parsed_data = JSON.parse(api_data)
    
    user = SpotifyUser.find_or_create_by(spotify_id: parsed_data["id"])

    user["spotify_id"] = parsed_data["id"]
    user["country"] = parsed_data["country"]
    user["email"] = parsed_data["email"]
    user["followers"] = parsed_data["followers"]["total"]
    user["display_name"] = parsed_data["display_name"]
    user["has_paid_spotify"] = parsed_data["product"] == "premium"
    user["birthday"] = parsed_data["birthdate"]
    
    user.save

    VenueSpotifyUser.create({
      venue: venue,
      spotify_user: user  
    })

    self.get_top_artists(access_token, user)
  end

  def self.get_top_artists(access_token, user, url='https://api.spotify.com/v1/me/top/artists')

    api_data = RestClient.get(url, headers={'Authorization': 'Bearer ' + access_token})
    parsed_data = JSON.parse(api_data)

    # puts parsed_data
    # byebug

    parsed_data["items"].each.with_index(1) do |artist_object, index|
      self.parse_one_artist(artist_object, index, user)
    end
    
    if parsed_data["next"]
      self.get_top_artists(access_token, user, parsed_data["next"])
    end
  end

  def self.parse_one_artist(artist_object, index, user)
    artist = Artist.find_or_create_by(spotify_id: artist_object["id"])

    SpotifyUserArtist.create({
      spotify_user: user,
      artist: artist,
      rank: index
    })
  end
end
