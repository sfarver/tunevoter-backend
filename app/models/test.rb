require_relative '../config/environment.rb'

LastFMApi.get_similarity_score("Cher", Venue.first)
