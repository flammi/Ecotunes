class MusicexplorerController < ApplicationController
  def explorer
  end

  def search
    filter = params[:filter]
    @artists = Artist.where('name LIKE ?', "%" + filter + "%")
    @songs = Song.where('title LIKE ?', "%" + filter + "%")
    @albums = Album.where('name LIKE ?', "%" + filter + "%")

    render json: @artists.to_json(:include => [:albums , :songs => {:include => :albums}]);
  end

end
