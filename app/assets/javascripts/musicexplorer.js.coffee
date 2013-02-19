# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("#search").keyup -> 
    $.getJSON("/musicexplorer/search", {}, (json, resp) -> 
      $(json).each (artIndex, artist) ->
        artist_name = artist.name;
        $(artist.albums).each (albIndex, album) ->
          album_name = album.name;
          album_release = album.release;
          $(album.songs).each (songIndex, song) ->
            song_title = song.title;
            song_length = song.length;
            song_path = song.path;
            song_released = song.released;
            alert('Künstler ' + artist_name + ' Album: ' + album_name + ' Song: ' + song_title);
      );