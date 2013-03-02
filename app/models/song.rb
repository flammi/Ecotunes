# encoding: utf-8
class Song < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  attr_accessible :song, :image_path, :artist_id, :album_id, :artist, :genre_id, :length, :path, :released, :title, :album, :genre, :finger_print, :acoust_id, :bitrate, :channel_mode, :sample_rate, :mpeg_version, :playlists
  belongs_to :artist
  belongs_to :album
  has_and_belongs_to_many :playlists
  belongs_to :genre
  has_attached_file :song,
    :url => "/:basename.:extension",
    :path => Preferences.mp3_folder + "/:basename.:extension"

  before_create :replace_characters

  def as_json(options={})
    {:title => self.title,
     :duration => (self.seconds_to_duration self.length),
     :album => self.album,
     :artist => self.artist,
     :file_name => self.song_file_name,
     :id => self.id,
     :url => Preferences.mp3_url + self.song.url}
  end

  def seconds_to_duration(seconds)
    if seconds
      Time.at(seconds).utc.strftime("%M:%S")
    else
      "0:00"
    end
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

  

  def replace_characters

    replace_characters_hash = {
      'ä' => 'ae',
      'ö' => 'oe',
      'ü' => 'ue',

      'ß' => 'ss',
      '$' => 's',

      '_' => ' ',

      "'" => '',
      "´" => '',
      "`" => "",

      "[" => "(",
      "]" => ")",
      "?" => "",
      "!" => "",
      '/' => "-",
      '\\' => "-",

      "featuring" => "ft",
      " feat. " => " ft ",
      " feat " => " ft ",
      " ft. " => " ft ",
      "." => "",
      "," => "",    

      'à' => 'a',
      'á' => 'a',
      'â' => 'a',
      'ã' => 'a',

      'ç' => 'c',

      'è' => 'e',
      'é' => 'e',
      'ê' => 'e',
      'ë' => 'e',

      'ì' => 'i',
      'í' => 'i',
      'î' => 'i',
      'ï' => 'i',

      'ñ' => 'n',

      'ò' => 'o',
      'ó' => 'o',
      'ô' => 'o',
      'õ' => 'o',

      'ù' => 'u',
      'ú' => 'u',
      'û' => 'u',

      'ý' => 'y',
      'ÿ' => 'y',

      '$' => 's',
      '+' => '&',
    }
    if song_file_name != nil
      extension = File.extname(song_file_name).downcase
      name = File.basename(self.song_file_name, ".mp3")
      replace_characters_hash.each{|k, v| name.gsub!(k,v)}
      self.song.instance_write(:file_name, "#{name}#{extension}")
    end
  end

end
