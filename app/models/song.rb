class Song < ActiveRecord::Base
  attr_accessible :song, :artist_id, :album_id, :artist, :genre_id, :length, :path, :released, :title, :album, :genre, :finger_print, :bitrate, :channel_mode, :sample_rate, :mpeg_version, :playlists
  belongs_to :artist
  belongs_to :album
  has_and_belongs_to_many :playlists
  belongs_to :genre
  has_attached_file :song,
    :url => "/system/:attachment/:basename.:extension"

include Rails.application.routes.url_helpers

  def as_json(options={})
    {:title => self.title,
     :duration => self.length,
     :album => self.album,
     :artist => self.artist,
     :file_name => self.song_file_name,
     :id => self.id,
     :url => self.song.url}
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
