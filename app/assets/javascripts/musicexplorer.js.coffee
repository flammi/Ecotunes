# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("#search").keyup -> 
    $.getJSON("/musicexplorer/search?filter=" + $("#search").val(), {}, (json, resp) -> 
      $("#0_col_artist").empty();
      $("#1_col_artist").empty();
      $("#2_col_artist").empty();

      $("#0_col_album").empty();
      $("#1_col_album").empty();
      $("#2_col_album").empty();

      $("#0_col_song").empty();
      $("#1_col_song").empty();
      $("#2_col_song").empty();


      $(json).each (objIndex, obj) ->
        $(obj.artists).each (artistIndex, artist) ->
          $("#" + artistIndex % 3 + "_col_artist").append("<li>" + artist.name + "</li>");
        $(obj.albums).each (albIndex, album) ->
          $("#" + albIndex % 3 + "_col_album").append("<li>" + album.name + "</li>");
        $(obj.songs).each (songIndex, song) ->
          $("#" + songIndex % 3 + "_col_song").append("<li>" + song.title + "</li>");
      );

$(document).ready ->
  $("#jquery_jplayer_1").jPlayer
    ready: ->
      $(this).jPlayer "setMedia",
        m4a: "http://www.jplayer.org/audio/m4a/Miaow-07-Bubble.m4a"
        oga: "http://www.jplayer.org/audio/ogg/Miaow-07-Bubble.ogg"


    swfPath: "/js"
    supplied: "m4a, oga"