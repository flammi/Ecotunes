class ImportJob < ActiveRecord::Base
  attr_accessible :filecount, :filecount_processed, :files, :picked

  def load_unimported
    unsorted_path = Preferences.mp3_unsorted_folder
    sorted_path = Preferences.mp3_folder

    @items = []
    Dir.glob(unsorted_path + "/*.mp3") do |file_name|
      @items << file_name
    end

    @filecount = @items.count
    @filecount_processed = 0
  end

  def process
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
  end
end
