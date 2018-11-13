class LastFMApi
  def self.get_similarity_score(artist_name, venue)
    similar_artists = self.get_similar_artists(artist_name)

    venue_artists = venue.most_popular_artists(true)

    self.thiswillcallitself(similar_artists, venue_artists)
  end

  private

  def self.get_similar_artists(artist_name)
    api_data = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=artist.getsimilar&artist=#{artist_name}&api_key=#{ENV[last_fm_key]}&format=json")
    JSON.parse(api_data)
  end

  def self.thiswillcallitself(similar_artists, venue_artists)
      match_score = 0
      total_score = 0

      venue_artists.each do |artist|
        binding.pry

        if similar_artists.contains?(artist)
          match_score += similar_artists[artist].match * artist.score
        else
          

        total_score += artist.score
      end

    # take in similar artists and venue_artists arrays
    # set match percent equal to 0
    # iterate over venue artists to see if match similar artists
      # if equal, add to match percentage by their weight
      # if not:
        # request second layer of similar artists
        # recursively call method until artist_match_score is derived or confident enough

  end
end
