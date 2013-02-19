class Artist < ActiveRecord::Base
  attr_accessible :name, :albums
  has_many :songs, :uniq => true
  has_many :albums, :uniq => true
  accepts_nested_attributes_for :albums
end
