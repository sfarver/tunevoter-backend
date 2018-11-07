require_relative './spotify_api.rb'
require 'pry'
require 'base64'
require 'rest-client'
require 'figaro'

token = SpotifyApi.get_token

def enrich_artist_data(auth_token)
  Artist.all.each do |artist|
    url = "https://api.spotify.com/v1/artists/#{artist.spotify_id}"
    
    api_data = RestClient.get(url, headers={'Authorization': 'Bearer ' + auth_token})
    parsed_data = JSON.parse(api_data)
    
    artist.spotify_id = parsed_data["id"],
    artist.followers = parsed_data["followers"],
    artist.name = parsed_data["name"],
    artist.popularity = parsed_data["popularity"]
    
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
  end
end