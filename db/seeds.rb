# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Venue.find_or_create_by({
  slug: "codered",
  email: "admin@email.com",
  password_digest: Venue.digest('asdf')
})

# token = SpotifyApi.get_token
# 
# def enrich_artist_data(auth_token)
#   Artist.all.each do |artist|
# 
#     # require_relative './spotify_api.rb'
#     # require_relative './artist_genre.rb'
#     # require_relative './genre.rb'
#     # require 'active_record'
#     # require 'pry'
#     # require 'base64'
#     # require 'rest-client'
#     # require 'figaro'
# 
#     fixed_artist_id = json = JSON.parse(artist.spotify_id[1..24])
# 
#     url = "https://api.spotify.com/v1/artists/#{fixed_artist_id}"
# 
#     api_data = RestClient.get(url, headers={'Authorization': 'Bearer ' + auth_token})
#     parsed_data = JSON.parse(api_data)
# 
#     artist.update({
#       spotify_id: parsed_data["id"],
#       followers: parsed_data["followers"]["total"],
#       name: parsed_data["name"],
#       popularity: parsed_data["popularity"]
#     })
# 
#     if !parsed_data["genres"].empty?
#       parsed_data["genres"].each do |genre|
#         artist_genre = Genre.find_or_create_by(
#           name: genre
#         )
# 
#         ArtistGenre.find_or_create_by(
#           artist: artist,
#           genre: artist_genre
#         )
#       end
#     end
#   end
# end
# 
# enrich_artist_data(token)
