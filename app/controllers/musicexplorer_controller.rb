class MusicexplorerController < ApplicationController
  def explorer
  end

  def search
    @artists = Artist.all
    @songs = Song.all
    @albums = Album.all

    render json: @artists.to_json(:include => [:albums , :songs => {:include => :album}]);
  end

end
