class Album < ActiveRecord::Base
  attr_accessible :artist_id, :name, :release
end
