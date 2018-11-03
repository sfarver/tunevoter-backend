class CreateVenueSpotifyUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :venue_spotify_users do |t|
      t.belongs_to :venue
      t.belongs_to :spotify_user
      t.timestamps
    end
  end
end
