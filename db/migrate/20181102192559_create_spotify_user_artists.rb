class CreateSpotifyUserArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :spotify_user_artists do |t|
      t.belongs_to :spotify_user
      t.belongs_to :artist
      t.string :time_duration
      t.timestamps
    end
  end
end
