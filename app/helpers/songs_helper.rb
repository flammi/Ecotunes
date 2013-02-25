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
    apikey = "352e35485dead90ec0179be83979e561"
    secret = "d3044af5b2569b22b024a177d0cc555d"
    lastfm = Lastfm.new(apikey, secret)
    #token = lastfm.auth.get_token
    #lastfm.session = lastfm.auth.get_session(:token => token)['key']
    begin
      lastfm.album.get_info(artist_name, album_name)
    rescue Lastfm::ApiError
      nil
    end
  end


end
