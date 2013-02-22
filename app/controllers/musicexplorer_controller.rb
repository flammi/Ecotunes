class MusicexplorerController < ApplicationController
  def explorer
  end

  def search
    filter = params[:filter]
    if filter == nil
      filter = ""
    end
    @artists = Artist.where('name LIKE ?', "%" + filter + "%")
    @songs = Song.where('title LIKE ?', "%" + filter + "%")
    @albums = Album.where('name LIKE ?', "%" + filter + "%")



    render json: {:songs => @songs}
  end

  def stream_song
    param = params[:filename]
    send_file "/home/daniel/awe07/ecotunes/public/" + param, :type=>"audio/mp3", :stream => true, :buffer_size => 4096
  end
end
