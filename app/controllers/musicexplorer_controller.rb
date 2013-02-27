class MusicexplorerController < ApplicationController
  def explorer
     @playlists = Playlist.all
  end

  def search
    filter = params[:filter]
    if filter == nil
      filter = ""
    end
    @songs = Song.joins(:album).joins(:artist).where('albums.name LIKE ? or artists.name LIKE ? or title LIKE ?', "%" + 
      filter + "%", "%" + filter + "%", "%" + filter + "%").paginate(:page => params[:page], :per_page => 20)


    render json: {:songs => @songs}
  end

end
