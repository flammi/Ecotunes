require "mp3info"

desc "Import files from unsorted dir"
task :import_music => :environment do
  puts "Starting background import agent..."
  app_control = ApplicationController.new
  loop {
    puts "Picking job out of the database..."
    result = ImportJob.all
    if result.count != 0
      puts "Got #{result.count} jobs!"
      job = result[0]
      puts "Found. Importing #{job.filecount} files ..."
      
      #Process the import
      job.process app_control
      job.destroy
    else
      puts "Nothing found"
      sleep 1
    end
  }
end
