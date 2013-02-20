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

    render json: {:artists => @artists, :albums => @albums, :songs => @songs}
  end

end
