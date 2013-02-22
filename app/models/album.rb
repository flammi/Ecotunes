class Album < ActiveRecord::Base
  attr_accessible :name, :release, :artists, :songs
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :songs

  def as_json(options={})
    {:name => self.name,
     :release => self.release,
     :artists => self.artists}
  end

end
