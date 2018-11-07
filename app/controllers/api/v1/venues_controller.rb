class Api::V1::VenuesController < ApplicationController
    skip_before_action :authorized, only: [:create]

  def create
    @venue = Venue.create(venue_params)
    if @venue.valid?
      render json: { venue: VenueSerializer.new(@venue) }, status: :created
    else
      render json: { error: 'failed to create venue' }, status: :not_acceptable
    end
  end
  
  def top_artists
    venue = current_venue
      
    artists_list = venue.most_popular_artists(true)

    if artists_list.empty?
      render json: { status: 500, error: 'could not retrieve top artists'}
    else
      render json: artists_list
    end
  end
  
  def top_genres
    venue = current_venue
    
    genre_list = venue.most_popular_genres(true)
    
    if genre_list.empty?
      render json: { status: 500, error: 'could not retrieve top genres'}
    else
      render json: genre_list
    end
  end

  private

  def venue_params
    params.require(:venue).permit(:email, :password)
  end
end
