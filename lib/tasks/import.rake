desc "Import files from unsorted dir"
task :import_music => :environment do
  puts "Starting background import agent..."
  loop {
    puts "Picking job out of the database..."
    result = ImportJob.find_by_picked(false)
    if result
      puts "Found. Importing #{job.filecount} files ..."
      job = result.first
      job.picked = true
      job.save
      
      #Process the import
      #job.process
    else
      puts "Nothing found"
      sleep 1
    end
  }
end
