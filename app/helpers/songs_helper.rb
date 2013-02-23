module SongsHelper

  def seconds_to_duration(seconds)
    Time.at(seconds).utc.strftime("%M:%S min")
  end

  def fingerprint_and_duration filename
    if filename != nil
      IO.popen(["fpcalc", Rails.root.join("public", "system", "songs", "attaches", filename).to_s]) do |io|
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

end
