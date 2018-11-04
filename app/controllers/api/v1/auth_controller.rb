class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @venue = Venue.find_by(email: venue_auth_params[:email])

    if @venue && @venue.authenticate(venue_auth_params[:password])
      token = encode_token({ venue_id: @venue.id })
      render json: { venue: VenueSerializer.new(@venue), jwt: token, venue_id: @venue.id }, status: :accepted
    else
      render json: { message: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def venue_auth_params
    params.require(:venue).permit(:email, :password)
  end
end
