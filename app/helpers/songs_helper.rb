module SongsHelper
require 'lastfm'

  def seconds_to_duration(seconds)
    Time.at(seconds).utc.strftime("%M:%S min")
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
