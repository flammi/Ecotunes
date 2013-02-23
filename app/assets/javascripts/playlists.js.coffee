# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
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
      #$("#alert-info").opacity = 1 #pruefen ob code 200 zurueckkam
      #$("#alert-info").delay(2200).fadeOut(300);
    ).error ->
      #$("#alert-error").opacity = 1 #pruefen ob code 200 zurueckkam
      #$("#alert-error").delay(2200).fadeOut(300);
