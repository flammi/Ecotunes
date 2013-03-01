# -*- coding: utf-8 -*-
class PlaylistsController < ApplicationController
  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @playlists }
    end
  end

def newsong
    @playlist = Playlist.find(params[:playlistid])
    @song = Song.find_by_id(params[:songid])
    @playlist.songs << @song
    if @playlist.save
      render :json => { }
    else
      render :json => { }, :status => 500
    end
end

def addalbum
  songs = params[:song]
  backlink = params[:backlink]
  if songs != nil
    flash[:notice] = "Die Lieder wurden der Playlist hinzugefügt!"
    playlist = Playlist.find(params[:playlist])
    songs.each do |song_id|
      song = Song.find(song_id.to_i)
      playlist.songs << song
    end
    playlist.save
  else
    flash[:notice] = "Es wurde keine Lieder ausgewählt die der Playlist hinzugefügt werden können!"
  end
  redirect_to backlink
end

def removesong
    @playlist = Playlist.find(params[:playlistid])
    elem = @playlist.songs.find(params[:songid])
    if elem != nil
      @playlist.songs.delete(elem)
    end
    if @playlist.save
      render :json => { }
    else
      render :json => { }, :status => 500
    end
end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
    @playlist = Playlist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @playlist }
    end
  end

  # GET /playlists/new
  # GET /playlists/new.json
  def new
    @playlist = Playlist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @playlist }
    end
  end

  # GET /playlists/1/edit
  def edit
    @playlist = Playlist.find(params[:id])
  end

  # POST /playlists
  # POST /playlists.json
  def create
    @playlist = Playlist.new(params[:playlist])

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to playlists_path, notice: 'Playlist was successfully created.' }
        format.json { render json: @playlist, status: :created, location: @playlist }
      else
        format.html { render action: "new" }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /playlists/1
  # PUT /playlists/1.json
  def update
    @playlist = Playlist.find(params[:id])

    respond_to do |format|
      if @playlist.update_attributes(params[:playlist])
        format.html { redirect_to playlists_path, notice: 'Playlist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy

    render :json => { }
  end
end
