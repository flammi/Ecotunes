class Artist < ActiveRecord::Base
  attr_accessible :name, :albums
  has_many :songs
  has_many :albums
  accepts_nested_attributes_for :albums
end
