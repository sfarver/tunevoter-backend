class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, ENV['secret'])
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]

      begin
        JWT.decode(token, ENV['secret'], true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_venue
    if decoded_token
      venue_id = decoded_token[0]['venue_id']
      @venue = Venue.find(venue_id)
    end
  end

  def is_logged_in
    !!current_venue
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless is_logged_in
end
end
