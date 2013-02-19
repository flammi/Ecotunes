class Album < ActiveRecord::Base
  attr_accessible :artist_id, :name, :release, :artist, :songs
  belongs_to :artist
  has_many :songs, :uniq => true
  accepts_nested_attributes_for :songs
end
