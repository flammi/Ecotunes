
class ManagementController < ApplicationController
  def management
  end
  def duplicatecheck
    songs = Song.all
    songs_without_dups = songs.uniq do |song| song.finger_print end

    songs_to_delete = songs - songs_without_dups
    @duplicate_count = songs_to_delete.count
    songs_to_delete.each { |song|
      song.destroy
    }
  end

  def import
    unsorted_path = Preferences.mp3_unsorted_folder
    sorted_path = Preferences.mp3_folder
    @items = []
    Dir.glob(unsorted_path + "/*.mp3") do |file_name|
      temp_song = Song.new
      temp_song.song = File.open(file_name)
      create_song temp_song
      if temp_song.save     
        @items << file_name
        File.delete(file_name)
      end
    end
    return @items
  end
end
