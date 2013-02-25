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
end
