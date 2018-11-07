class AddFollowersNameAndPopularityToArtists < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :followers, :integer
    add_column :artists, :name, :string
    add_column :artists, :popularity, :integer
  end
end
