
require 'net/http'
include ActionView::Helpers::OutputSafetyHelper

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to login_path, :alert => exception.message
  end

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
          album.save
          artist.albums << album
        end
        song.album = album
        album.songs << song
        album.artist = artist

        song.released = tag.year

        if tag.genre_s != nil
        end
      end
    end   

    artist.save
    album.save

    picture = get_album_cover artist.name, album.name
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

  def get_album_infos artist_name, album_name
    pair = Pair.new artist_name, album_name
    if Rails.cache.exist?(pair)
      puts "value from cache"
      return Rails.cache.read(pair)
    end
    lastfm = Lastfm.new(Preferences.apikey, Preferences.secret)
     if artist_name and album_name
      begin
        result = lastfm.album.get_info(artist_name, album_name)
        Rails.cache.write(pair, result)
        puts "added in cache"
        return result
      rescue Lastfm::ApiError
      end
    end
    return nil
  end
  
  def get_description_from_album artist_name, album_name
    result = get_album_infos artist_name, album_name
    if result != nil
      if result.has_key?('wiki')
        if result['wiki'].has_key?('content')
          return result['wiki']['content']
        end
      end
    end
    return nil
  end


  def get_songs_from_album artist_name, album_name
    result = get_album_infos artist_name, album_name
    if result != nil
      if result.has_key?('tracks')
        if result['tracks'].has_key?('track')
          tracks = result['tracks']['track']
          if tracks.kind_of?(Array)
            return tracks.map {|track| {"rank" => track['rank'], "name" => track['name'], "duration" => track['duration']}} #length kriegt man auch z.b.
          else
            #kein album sondern wohl eine single
            if tracks.has_key?('rank')
              if tracks.has_key?('name')
                return [{"rank" => tracks['rank'], "name" => tracks['name']}]
              end
            end
          end
        end
      end
    end
    return nil
  end

  def get_album_cover artist_name, album_name
    result = get_album_infos artist_name, album_name
    if result != nil
      image = result["image"].last #best quality
      image_result = nil
      if image != nil
        image_result = image['content']
        return image_result     
      end
    end
    return nil
  end

  def fading_flash_message(text, seconds=3)
    raw text +
      <<-EOJS
        <script type='text/javascript'>
          Event.observe(window, 'load',function() { 
            setTimeout(function() {
              message_id = $('notice') ? 'notice' : 'warning';
              new Effect.Fade(message_id);
            }, #{seconds*1000});
          }, false);
        </script>
      EOJS
  end

  def get_artist_information artist_name
    lastfm = Lastfm.new(Preferences.apikey, Preferences.secret)
     if artist_name
      begin
        result = lastfm.artist.get_info(artist_name)
        return result
      rescue Lastfm::ApiError
      end
    end
    return nil
  end
 

end
