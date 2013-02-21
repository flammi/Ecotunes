require "rubygems"
require "mp3info"

class SongsController < ApplicationController
  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @song = Song.find(params[:id])
    @duration = view_context.seconds_to_duration(@song.length) 

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/new
  # GET /songs/new.json
  def new
    @song = Song.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/1/edit
  def edit
    @song = Song.find(params[:id])
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(params[:song])

    if @song.attach != nil 
      tag = {}
      if @song.save
        Mp3Info.open( @song.attach.path ) do |mp3|
          @song.length = mp3.length
          @song.bitrate = mp3.bitrate
          @song.channel_mode = mp3.channel_mode
          @song.sample_rate = mp3.samplerate
          @song.mpeg_version = mp3.mpeg_version
          
          if mp3.tag != {}
            tag = mp3.tag
          elsif mp3.tag2 != {}
            tag = mp3.tag2
          end
        end

        #Set tags
        if tag != {}

          @song.title = tag.title
          #needed in album and artist
          artist = nil
          
          artist = Artist.where( :name == tag.artist).first
          if artist != nil
            @song.artists << artist
          else
            artist = Artist.new
            artist.name = tag.artist
            @song.artists << artist
            artist.save
          end

          album = Album.where( :name == tag.album).first
          if album != nil
            @song.albums << album
          else
            album = Album.new
            album.name = tag.album
            @song.albums << album
            album.save
          end

          if album != nil
              if artist.albums.where(:album_id == album.id) == nil
                artist.albums << new_album
              end
          end

            #only tracknum, if album exists
            if tag.tracknum != nil
              #TODO wie behandeln wir das? Man brauch wohl ne neue Klasse... ein Song hat pro Album halt eine neue Tracknr
            end

            @song.released = tag.year

          if tag.genre_s != nil
          end

        end
      end
    end   

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render json: @song, status: :created, location: @song }
      else
        format.html { render action: "new" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.json
  def update
    @song = Song.find(params[:id])

    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song = Song.find(params[:id])
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end

end
