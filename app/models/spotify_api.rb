class SpotifyApi
  def self.get_all_spotify_info(access_token, venue)
    self.get_user_info(access_token, venue)
  end
  
  # def get_similar_artists(spotify_artist_id)
  #   url = 'https://api.spotify.com/v1/me'
  # end

  def self.update_artist_data(spotify_artist_id)
    url = "https://api.spotify.com/v1/artists/#{spotify_artist_id}"
    
    api_data = RestClient.get(url, headers={'Authorization': 'Bearer ' + access_token})
    parsed_data = JSON.parse(api_data)
  end
  
  def self.get_token
    url = 'https://accounts.spotify.com/api/token'
    
    enc_keys = 'NTZjYzkwZmQzYjdkNDM4Zjg4ZjVlZmMyOTlhYWRhMGI6ZDIyZmJhMjAxN2EwNGYwMGFjNmFjMTQwNDMwOTQ1ODI='
    
     # Figaro / Env not working Base64.encode64("#{ENV['spotify_key']}:#{ENV['spotify_secret']}")
    
    response = RestClient.post(
      url,
      { 
        'grant_type': 'client_credentials'
      },
      {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': "Basic #{enc_keys}"
      }
    )
    
    parsed_data = JSON.parse(response)
    token = parsed_data["access_token"]
  end

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

    VenueSpotifyUser.find_or_create_by(
      venue: venue,
      spotify_user: user  
    )

    self.get_top_artists(access_token, user)
  end

  def self.get_top_artists(access_token, user, url='https://api.spotify.com/v1/me/top/artists')

    api_data = RestClient.get(url, headers={'Authorization': 'Bearer ' + access_token})
    parsed_data = JSON.parse(api_data)

    parsed_data["items"].each.with_index(1) do |artist_object, index|
      self.parse_one_artist(artist_object, index, user)
    end
    
    if parsed_data["next"]
      self.get_top_artists(access_token, user, parsed_data["next"])
    end
  end

  def self.parse_one_artist(artist_object, index, user)
    artist = Artist.find_or_create_by(
      spotify_id: artist_object["id"],
      followers: artist_object["followers"],
      name: artist_object["name"],
      popularity: artist_object["popularity"]
    )
    
    if !artist_object["genres"].empty?
      artist_object["genres"].each do |genre|
        artist_genre = Genre.find_or_create_by(
          name: genre
        )
        
        ArtistGenre.find_or_create_by(
          artist: artist,
          genre: artist_genre
        )
      end
    end

    SpotifyUserArtist.create({
      spotify_user: user,
      artist: artist,
      rank: index
    })
  end
end
