class Genre < ActiveRecord::Base
  attr_accessible :name, :songs
  has_many :songs
end
