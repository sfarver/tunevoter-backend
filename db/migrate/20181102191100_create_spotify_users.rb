class CreateSpotifyUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :spotify_users do |t|
      t.string :spotify_id
      t.string :display_name
      t.string :email
      t.boolean :has_paid_spotify
      t.date :birthday
      t.string :country
      t.integer :followers
      t.timestamps
    end
  end
end
