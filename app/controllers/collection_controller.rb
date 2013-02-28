class CollectionController < ApplicationController
  def seconds_to_duration(seconds)
    Time.at(seconds).utc.strftime("%M:%S")
  end

  def lookup_song title, artist
    songs = Song.joins(:artist).where("title LIKE ? and lower(artists.name) LIKE lower(?)", title, artist)
    if songs.length > 0
      return songs[0]
    else
      return nil
    end
  end

  def collection
    album = params[:album] 
    artist = params[:artist]
    @result_available = false
    if album and artist
      @result_rows = []
      songs = get_songs_from_album artist, album
      songs.each do |song| 
        entry = Hash.new
        entry['rank'] = song['rank']
        entry["title"] = song['name']
        song_in_db = lookup_song song['name'], artist
        if song_in_db != nil
          entry["available"] = true 
          entry["song_id"] = song_in_db.id
        else 
          entry["available"] = false
        end
        entry["duration"] = seconds_to_duration(song['duration'].to_i)
        @result_rows << entry
      end
      @result_available = true
    end
  end
end
