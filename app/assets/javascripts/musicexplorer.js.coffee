# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $.getJSON("/musicexplorer/search?filter=" + $("#search").val(), {}, (json, resp) -> 
          fillList json
  );
  $("#search").keyup -> 
    $.getJSON("/musicexplorer/search?filter=" + $("#search").val(), {}, (json, resp) -> 
        fillList json
    );

fillList = (jsonString) ->
  $("#table-content").empty()
  $(jsonString).each (objIndex, obj) ->
    $(obj.songs).each (songIndex, song) ->
          newEntry = $("#row-entry-container").children().clone();
          newEntry.find(".row-track").text(song.title)
          if song.artist != null
            newEntry.find(".row-artist").text(song.artist.name)
          newEntry.find(".row-time").text(song.duration)
          if song.album != null
            newEntry.find(".row-album").text(song.album.name)
          newEntry.find(".row-buttons").find(".play-btn").on "click", ->
            $("#jquery_jplayer_1").jPlayer "setMedia", {mp3: "http://localhost:3000#{song.url}"}
            $("#jquery_jplayer_1").jPlayer "play"
            $("#song-description").text song.title
          newEntry.find(".row-buttons").find(".search-btn").attr("href", "/songs/ #{song.id}")
          $("#table-content").append(newEntry)
          newEntry.find(".row-buttons").find(".playlist-button").on "click", ->
            addSongToPlaylist $(this).data("playlistid"), song.id

addSongToPlaylist = (playlistid, songid) ->
  $.post("/playlists/newsong", songid: "#{songid}", playlistid: "#{playlistid}"
    ).done((data) ->
      #$("#alert-info").opacity = 1 #pruefen ob code 200 zurueckkam
      #$("#alert-info").delay(2200).fadeOut(300);
    ).error ->
      #$("#alert-error").opacity = 1 #pruefen ob code 200 zurueckkam
      #$("#alert-error").delay(2200).fadeOut(300);

