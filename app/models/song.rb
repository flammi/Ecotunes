class Song < ActiveRecord::Base
  attr_accessible :song, :artists, :genre_id, :length, :path, :released, :title, :albums, :genre, :finger_print, :bitrate, :channel_mode, :sample_rate, :mpeg_version, :playlists
  has_attached_file :song
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :albums
  has_and_belongs_to_many :playlists
  belongs_to :genre

include Rails.application.routes.url_helpers

  def as_json(options={})
    {:title => self.title,
     :duration => self.length,
     :albums => self.albums,
     :artists => self.artists,
     :file_name => self.song_file_name,
     :id => self.id}
  end

  def to_jq_upload
    {
      "name" => read_attribute(:song_file_name),
      "size" => read_attribute(:song_file_size),
      "url" => song.url(:original),
      "delete_url" => song_path(self),
      "delete_type" => "DELETE" 
    }
  end

end
