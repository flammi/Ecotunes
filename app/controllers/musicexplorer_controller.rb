class MusicexplorerController < ApplicationController
  def explorer
     @playlists = Playlist.all
  end

  def search
    filter = params[:filter]
    if filter == nil
      filter = ""
    end
    @songs = Song.where('title LIKE ?', "%" + filter + "%").paginate(:page => params[:page], :per_page => 20)

    render json: {:songs => @songs}
  end

end
