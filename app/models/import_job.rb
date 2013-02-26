class ImportJob < ActiveRecord::Base
  attr_accessible :filecount, :filecount_processed, :files, :picked

  def load_unimported
    unsorted_path = Preferences.mp3_unsorted_folder
    sorted_path = Preferences.mp3_folder
    
    #Look in old jobs and get a file list of already imported files
    old_jobs = ImportJob.all
    old_files = Set.new
    old_jobs.each do |job|
      if job.files != nil
        job.files.split("|").each do |file|
          old_files << file
        end
      end
    end

    @items = []
    Dir.glob(unsorted_path + "/*.mp3") do |file_name|
      if not old_files.include? file_name
        @items << file_name
      end
    end

    self.files = @items.join("|")
    self.filecount = @items.count
    self.filecount_processed = 0
  end

  def file_processed
    self.filecount_processed += 1
    self.save
  end

  def process
    self.files.split("|").each do |file|
      temp_song = Song.new
      temp_song.song = File.open(file)
      create_song temp_song
      if temp_song.save     
        file_processed
        File.delete(file_name)
      end
    end
  end
end
