class AlbumsController < ApplicationController
  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @album = Album.find(params[:id])
    if @album.artist != nil
      @songs = get_songs_from_album  @album.artist.name, @album.name
      @song_list = []
      if @songs
        @songs.each do |song|
          entry = Hash.new
          entry['rank'] = song['rank']
          entry['title'] = song['name']
          entry['artist'] = @album.artist.name
          song_in_db = lookup_song song['name'], @album.artist.name
          if song_in_db != nil
            entry['available'] = true
            entry['song_id'] = song_in_db.id
          else
            entry['available'] = false
          end
          entry['duration'] = seconds_to_duration(song['duration'].to_i)
          @song_list << entry
        end
      end
      @album_cover = get_album_cover @album.artist.name, @album.name
      @description = get_description_from_album @album.artist.name, @album.name
    end

    @songs = [] if @songs == nil
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end


  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end
end
