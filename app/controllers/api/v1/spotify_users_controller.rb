class Api::V1::SpotifyUsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  
  def index 
    venue = current_venue
    
    render json: venue.users_by_date
  end
  
  def create
    venue = Venue.find_by(slug: spotify_user_params[:venue_slug])
    
    result = SpotifyApi.get_all_spotify_info(spotify_user_params[:access_token], venue)
  end
  
  private
  
  def spotify_user_params
    params.require(:spotify_user).permit(:access_token, :venue_slug)
  end
end