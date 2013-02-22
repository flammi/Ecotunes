class Song < ActiveRecord::Base
  attr_accessible :artists, :genre_id, :length, :path, :released, :title, :albums, :attach, :genre, :finger_print, :bitrate, :channel_mode, :sample_rate, :mpeg_version, :playlists
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :albums
  has_and_belongs_to_many :playlists
  belongs_to :genre
  has_attached_file :attach,
    :url => "/system/:class/:attachment/:basename.:extension"

  
  def validate
    file = self.attach.to_file(:original)
    data = File.read(file)
    # Do some validation on data
    errors.add_to_base "File format invalid" if data.nil?
  end

  def as_json(options={})
    {:title => self.title,
     :duration => self.length,
     :albums => self.albums,
     :artists => self.artists,
     :file_name => self.attach_file_name,
     :id => self.id}
  end

end
