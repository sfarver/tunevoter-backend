class Artist < ApplicationRecord
  has_many :genres, through: :artist_genres
end