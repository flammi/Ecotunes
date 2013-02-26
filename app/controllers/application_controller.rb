
require 'net/http'

class ApplicationController < ActionController::Base
  protect_from_forgery

  def fingerprint_and_duration filepath
    if filepath != nil
      IO.popen(["fpcalc", filepath]) do |io|
        output = io.read
        if output != nil
          output_as_array = output.split "\n"
          if output_as_array != nil
            duration = output_as_array[1].sub(/DURATION=/,"")
            fingerprint = output_as_array[2].sub(/FINGERPRINT=/, "")
            return duration, fingerprint
          end
        end
      end
    end
    return nil, nil
  end

  def create_song song
    if song.song != nil
      tag = {}
      song.title = song.song_file_name

      if song.save
        duration, fingerprint = fingerprint_and_duration "#{song.song.path}"
        #acoust_id, score = get_acoust_id duration, fingerprint
        #puts "acoustid: #{acoust_id} score: #{score}"
        song.finger_print = fingerprint
        song.length = duration
        Mp3Info.open( song.song.path ) do |mp3|
          #song.length = mp3.length #fingerprint has same value
          song.bitrate = mp3.bitrate
          song.channel_mode = mp3.channel_mode
          song.sample_rate = mp3.samplerate
          song.mpeg_version = mp3.mpeg_version

          if mp3.tag != {}
            tag = mp3.tag
          elsif mp3.tag2 != {}
            tag = mp3.tag2
          end
        end
      end

      #Set tags
      if tag != {}
        if tag.title != nil
          song.title = tag.title
        end

        #needed in album and artist
        
        artist = Artist.find_by_name(tag.artist)
        if artist == nil
          artist = Artist.create
          artist.name = tag.artist
          song.artist = artist
        end
        artist.songs << song

        album = Album.find_by_name(tag.album)
        
        if album == nil
          album = Album.create
          album.name = tag.album
          album.artist = artist
          artist.albums << album
        end
        song.album == album
        album.songs << song

        #only tracknum, if album exists
        if tag.tracknum != nil
          #TODO wie behandeln wir das? Man brauch wohl ne neue Klasse... ein Son
        end

        song.released = tag.year

        if tag.genre_s != nil
        end
      end
    end   

    artist.save
    album.save

    picture, description = get_album_info artist.name, album.name
    if picture != nil
      song.image_path = picture
    end
    return song
  end

  def get_acoust_id duration, fingerprint
    result_score = 0
    if fingerprint != nil && duration.to_i > 10
      uri = URI.parse("http://api.acoustid.org/v2/lookup")
      json_response =  Net::HTTP.post_form(uri, 
        {"client" => Preferences.acoustid,
          "duration" => duration,
          "fingerprint" => fingerprint})
      if json_response != nil 
          result = JSON.parse(json_response.body)
          if result["status"] != "error"
            return result["results"][0]["score"], result["results"][0]["id"]
          else
            puts result
          end
      end
    end
    return nil
  end

  def get_album_info artist_name, album_name
    lastfm = Lastfm.new(Preferences.apikey, Preferences.secret)
    #token = lastfm.auth.get_token
    #lastfm.session = lastfm.auth.get_session(:token => token)['key']
    if artist_name and album_name
      begin
        result = lastfm.album.get_info(artist_name, album_name)
        image = result["image"].last #best quality
        description = result["wiki"]
        description_result = nil
        image_result = nil
        if description != nil
          description_result = description["summary"]
        end
        if image != nil
          image_result = image['content']
          puts image_result
        end
        return image_result, description_result 
      rescue Lastfm::ApiError
      end
    end
    return nil, nil
  end

end
