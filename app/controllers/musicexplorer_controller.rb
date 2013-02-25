class MusicexplorerController < ApplicationController
  def explorer
     @playlists = Playlist.all
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

end
