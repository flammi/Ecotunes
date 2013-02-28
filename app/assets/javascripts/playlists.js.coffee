# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->

 window.onbeforeunload = ->
    localStorage.setItem "playlist", JSON.stringify myPlaylist.playlist
    localStorage.setItem "current", myPlaylist.current
    localStorage.setItem "time", $(".jp-current-time").html()
    localStorage.setItem "playing", $('#jquery_jplayer_1').data().jPlayer.status.paused
    
  playlist = JSON.parse(localStorage.getItem "playlist")
  myPlaylist = new jPlayerPlaylist(
    jPlayer: "#jquery_jplayer_1" 
    cssSelectorAncestor: "#jp_container_1"
  , playlist,
    playlistOptions:
      enableRemoveControls: true
    swfPath: "../js"
    supplied: "webmv, ogv, m4v, oga, mp3"
    wmode: "window"
  )
  
  $(".play-btn").on "click", ->
    $("#jquery_jplayer_1").jPlayer "setMedia", {mp3: "http://localhost:3000" + $(this).data("path")}
    $("#jquery_jplayer_1").jPlayer "play"
    $("#song-description").text $(this).data("songtitle")
  $(".remove-btn").on "click", ->
    removeSongFromPlaylist $(this).data("playlistid"), $(this).data("songid"), $(this).closest("tr")

removeSongFromPlaylist = (playlistid, songid, row) ->
  $.post("/playlists/removesong", songid: "#{songid}", playlistid: "#{playlistid}"
    ).done((data) ->
      row.remove()
      #flash.now[:error] = "Could not save client"
      #render :action => "new"
      #$("#alert-info").opacity = 1 #pruefen ob code 200 zurueckkam
      #$("#alert-info").delay(2200).fadeOut(300);
    ).error ->
      #$("#alert-error").opacity = 1 #pruefen ob code 200 zurueckkam
      #$("#alert-error").delay(2200).fadeOut(300);
