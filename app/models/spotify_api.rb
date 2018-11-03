class SpotifyApi
  def get_all_spotify_info(access_token)
    get_top_artists(access_token)
    get_user_info(access_token)
  end
  
  private
  
  def self.get_top_artists(access_token)
    url = 'https://api.spotify.com/v1/me/top/artists'
    
    api_data = RestClient.get(url, headers={'Authorization': 'Bearer ' + access_token})
    parsed_data = JSON.parse(api_data)
    
    parsed_data["items"].each do |artist_object|
      self.parse_one_artist(artist_object)
    end
  end
  
  def self.get_user_info(access_token)
    url = 'https://api.spotify.com/v1/me'
    
    RestClient.get(url, headers={'Authorization': 'Bearer ' + access_token})
  end
  
  def self.parse_one_artist(artist_object)
    
  end
end
