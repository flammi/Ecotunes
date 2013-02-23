module SongsHelper

  def seconds_to_duration(seconds)
    Time.at(seconds).utc.strftime("%M:%S min")
  end

  def fingerprint_and_duration filename
    IO.popen(["fpcalc", filename]) do |io|
      output = io.read
      output_as_array = output.split "\n"
      duration = output_as_array[1].sub(/DURATION=/,"")
      fingerprint = output_as_array[2].sub(/FINGERPRINT=/, "")
      return duration, fingerprint
    end
  end

end
