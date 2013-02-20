class Artist < ActiveRecord::Base
  attr_accessible :name, :albums, :songs
  has_and_belongs_to_many :albums
  has_and_belongs_to_many :songs
  accepts_nested_attributes_for :albums
end
