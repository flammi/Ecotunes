class Song < ActiveRecord::Base
  attr_accessible :artists, :genre_id, :length, :path, :released, :title, :albums
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :albums
end
