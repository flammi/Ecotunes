class Playlist < ActiveRecord::Base
  attr_accessible :name, :songs
  has_and_belongs_to_many :songs
  
end
