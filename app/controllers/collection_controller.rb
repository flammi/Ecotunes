class CollectionController < ApplicationController
  def show_result_album
    album = params[:album] 
    artist = params[:artist]
    @result_rows = []
    songs = get_songs_from_album artist, album
    if songs != nil
      songs.each do |song| 
        entry = Hash.new
        entry['rank'] = song['rank']
        entry["title"] = song['name']
        entry["artist"] = artist
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
    end
    render :template => "collection/show_result.html.haml"
  end

  def show_result_parser
    text = params[:listing]

    #Zeilenweise einlesen
    @result_rows = []
    text.split("\r\n").each_with_index do |line, index|
      artist, song = line.split(" - ")
      song_in_db = lookup_song song, artist
      entry = Hash.new
      entry["rank"] = index + 1
      entry["title"] = song
      entry["artist"] = artist
      if song_in_db != nil
        debugger
        entry["available"] = true
        entry["song_id"] = song_in_db.id
        entry["duration"] = seconds_to_duration(song_in_db.length)
      else
        entry["available"] = false
      end
      @result_rows << entry
    end
    render :template => "collection/show_result.html.haml"
  end

  def collection
  end
end
