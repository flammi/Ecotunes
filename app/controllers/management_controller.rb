class ManagementController < ApplicationController
  def management
    @jobs = ImportJob.all
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
    job = ImportJob.new
    job.load_unimported
    job.save
  end

  def retagging
    sorted_path = Preferences.mp3_folder
    @items = []
    Dir.glob(sorted_path + "/*.mp3") do |file_name| 
      #some awesome magic here
      @items << file_name
    end
    return @items
  end
end
