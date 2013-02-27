class Artist < ActiveRecord::Base
  attr_accessible :name, :albums, :songs
  has_many :albums
  has_many :songs
  accepts_nested_attributes_for :albums

  def as_json(options={})
    {:name => self.name,
     :id => self.id
    }
  end
end
