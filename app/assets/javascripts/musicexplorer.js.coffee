# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("#search").keyup -> 
    $.getJSON("/musicexplorer/search", {}, (json, resp) -> 
      $("#0_col_artist").empty();
      $("#1_col_artist").empty();
      $("#2_col_artist").empty();

      $("#0_col_album").empty();
      $("#1_col_album").empty();
      $("#2_col_album").empty();

      $("#0_col_song").empty();
      $("#1_col_song").empty();
      $("#2_col_song").empty();

      $(json).each (artIndex, artist) ->
        $("#" + artIndex % 3 + "_col_artist").append("<li>" + artist.name + "</li>");

        $(artist.songs).each (songIndex, song) ->
            $("#" + songIndex % 3 + "_col_song").append("<li>" + song.title + "</li>");

        if artist.albums != undefined
          $(artist.albums).each (albIndex, album) ->
            $("#" + albIndex % 3 + "_col_album").append("<li>" + album.name + "</li>");
      );