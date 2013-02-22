# -*- coding: utf-8 -*-

def fingerprint_and_duration filename
	IO.popen(["fpcalc", filename]) do |io|
		output = io.read
		output_as_array = output.split "\n"
		duration = output_as_array[1].sub(/DURATION=/,"")
		fingerprint = output_as_array[2].sub(/FINGERPRINT=/, "")
		return duration, fingerprint
	end
end

duration, fingerprint = fingerprint_and_duration "/home/fabian/Musik/Zupfgeigenhansel - Nehmt Abschied Brüder.mp3"

puts duration
puts fingerprint
