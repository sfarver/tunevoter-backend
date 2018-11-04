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

  private

  def venue_params
    params.require(:venue).permit(:email, :password)
  end
end
