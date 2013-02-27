class Album < ActiveRecord::Base
  attr_accessible :name, :release, :artist, :songs
  belongs_to :artist
  has_many :songs
  accepts_nested_attributes_for :songs

  def as_json(options={})
    {:name => self.name,
     :release => self.release}
  end

end
