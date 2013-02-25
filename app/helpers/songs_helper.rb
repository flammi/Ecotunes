module SongsHelper
require 'lastfm'

  def seconds_to_duration(seconds)
    Time.at(seconds).utc.strftime("%M:%S min")
  end

end
