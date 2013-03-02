class MusicexplorerController < ApplicationController
  def explorer
     @playlists = Playlist.all
  end

  def sall query
    "%" + query + "%"
  end

  def search_title query
    Song.where("title LIKE ?", sall(query))
  end

  def search_artist query
    Song.joins(:artist).where("artists.name LIKE ?", sall(query))
  end

  def search_album query
    Song.joins(:album).where("albums.name LIKE ?", sall(query))
  end

  def search_all query
    Song.joins(:album).joins(:artist).where('albums.name LIKE ? or artists.name LIKE ? or title LIKE ?', "%" + 
      query + "%", "%" + query + "%", "%" + query + "%")
  end

  def search

    filter = params[:filter]
    if filter == nil
      filter = ""
    end

    search_keywords = {
      "album:" => :search_album,
      "title:" => :search_title,
      "artist:" => :search_artist,
      "" => :search_all
    }

    search_keywords.each do |keyword, method| 
      if filter.start_with? keyword
        songs = self.send(method, filter.sub(keyword, ""))
        songs = songs.paginate(:page => params[:page], :per_page => 20)
        render json: {:songs => songs}
        return
      end
    end



    render json: {:songs => @songs}
  end

end
