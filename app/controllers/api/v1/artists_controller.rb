class Api::V1::ArtistsController < ApplicationController

  def top_artists
    venue = current_venue
      
    artists_list = venue.most_popular_artists(true)

    
    if artists_list.empty?
      render json: { status: 500, error: 'could not retrieve top artists'}
    else
      render json: artists_list
    end
  end
end
