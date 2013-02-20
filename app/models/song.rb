class Song < ActiveRecord::Base
  attr_accessible :artists, :genre_id, :length, :path, :released, :title, :albums, :attach
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :albums
  has_attached_file :attach,
    :url => "/system/:class/:attachment/:basename.:extension"
 
   def validate
    file = self.attach.to_file(:original)
    data = File.read(file)
    # Do some validation on data
    errors.add_to_base "File format invalid" if data.nil?
  end

end
