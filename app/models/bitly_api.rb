class BitlyApi
  def self.create_bitly_link(venue)
    slug = venue.slug
    # NOTE: need to pass in campaign slug to set Spotify state to this
    # URL NEEDS TO BE THE SAME FOR EACH CLIENT OTHERWISE CAN'T BE FORWARDED BY SPOTIFY
    # HOW TO MAKE CALLBACK LANDING PAGE DISPLAY DIFFERENT THINGS BASED ON SPOTIFY STATE
  end
end