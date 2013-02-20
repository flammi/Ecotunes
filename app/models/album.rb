class Album < ActiveRecord::Base
  attr_accessible :name, :release, :artists, :songs
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :songs
end
