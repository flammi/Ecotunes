class Album < ActiveRecord::Base
  attr_accessible :artist_id, :name, :release, :artist
  belongs_to :artist
  has_many :songs
  accepts_nested_attributes_for :artist
end
