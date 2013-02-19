class Song < ActiveRecord::Base
  attr_accessible :album_id, :artist_id, :genre_id, :length, :path, :released, :title, :artist, :album
  belongs_to :artist
  belongs_to :album
end
