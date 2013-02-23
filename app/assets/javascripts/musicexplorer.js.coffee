# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $.getJSON("/musicexplorer/search?filter=", {}, (json, resp) -> 
        fillList json
  );

  $("#jquery_jplayer_1").jPlayer
    ready: ->
      $(this).jPlayer "setMedia",
        mp3: "/musicexplorer/stream_song?filename=fallingdown.mp3"
    swfPath: "/js"
    supplied: "mp3, oga"

  $("#search").keyup -> 
    $.getJSON("/musicexplorer/search?filter=" + $("#search").val(), {}, (json, resp) -> 
        fillList json
    );

fillList = (jsonString) ->
  $("#table-content").empty()
  $(jsonString).each (objIndex, obj) ->
    $(obj.songs).each (songIndex, song) ->
      $(song.albums).each (albIndex, album) ->
        $(album.artists).each (artistIndex, artist) ->
          newEntry = $("#row-entry-container").children().clone();
          newEntry.find(".row-track").text(song.title)
          newEntry.find(".row-artist").text(artist.name)
          newEntry.find(".row-time").text(song.duration)
          newEntry.find(".row-album").text(album.name)
          newEntry.find(".row-buttons").find(".play-btn").on "click", ->
            $("#jquery_jplayer_1").jPlayer "setMedia", {mp3: "http://localhost:3000#{song.url}"}
            $("#jquery_jplayer_1").jPlayer "play"
            $("#song-description").text song.title
          newEntry.find(".row-buttons").find(".search-btn").attr("href", "/songs/ #{song.id}")
          $("#table-content").append(newEntry)
          newEntry.find(".row-buttons").find(".playlist-button").on "click", ->
            addSongToPlaylist $(this).data("playlistid"), song.id

addSongToPlaylist = (playlistid, songid) ->
  $.post("/playlists/newsong", songid: "#{songid}", playlistid: "#{playlistid}").done (data) ->
    #$("#alert-info").opacity = 1 #pruefen ob code 200 zurueckkam
    #$("#alert-info").delay(2200).fadeOut(300);

