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
  $("#0_col_artist").empty();
  $("#1_col_artist").empty();
  $("#2_col_artist").empty();

  $("#0_col_album").empty();
  $("#1_col_album").empty();
  $("#2_col_album").empty();

  $("#0_col_song").empty();
  $("#1_col_song").empty();
  $("#2_col_song").empty();

  $(jsonString).each (objIndex, obj) ->
    $(obj.artists).each (artistIndex, artist) ->
      $("#" + artistIndex % 3 + "_col_artist").append(getArtistLayout artist);
    $(obj.albums).each (albIndex, album) ->
      $("#" + albIndex % 3 + "_col_album").append(getAlbumLayout album);
    $(obj.songs).each (songIndex, song) ->
      $("#" + songIndex % 3 + "_col_song").append(getSongLayout song);

  $(".play-song").on "click",  ->
    $("#jquery_jplayer_1").jPlayer "setMedia", {mp3: "http://localhost:3000/system/songs/attaches/" + $(this).data("path")}
    $("#jquery_jplayer_1").jPlayer "play"
    $("#song-description").text $(this).data("description")


getArtistLayout = (artist) ->
  string =  """
            <div class="btn-group open">
              <a class="btn dropdown-toggle" data-toggle="dropdown" href="#"> 
               #{ artist.name }
                <span class="icon-caret-down"></span>
              </a>
              <ul class="dropdown-menu">
                <li>
                  <a href="/artists/ #{ artist.id }">
                    <i class="i"></i>
                    Show Details
                  </a>
                </li>
              </ul>
            </div>
            """;
  return string;

getAlbumLayout = (album) ->
  string =  """
            <div class="btn-group open">
              <a class="btn dropdown-toggle" data-toggle="dropdown" href="#"> 
               #{ album.name }
                <span class="icon-caret-down"></span>
              </a>
              <ul class="dropdown-menu">
                <li>
                  <a href="/albums/ #{ album.id }">
                    <i class="i"></i>
                    Show Details
                  </a>
                </li>
              </ul>
            </div>
            """;
  return string;

getSongLayout = (song) ->
  string =  """
            <div class="btn-group open">
              <a class="btn dropdown-toggle" data-toggle="dropdown" href="#"> 
               #{ song.title }
                <span class="icon-caret-down"></span>
              </a>
              <ul class="dropdown-menu">
                <li class="play-song" data-path= #{song.attach_file_name} data-description= #{song.title}>
                  <a class="some-other-class">
                    <i class="icon-volume-up"></i>
                      Play
                  </a>
                </li>
                <li class="divider"></li>
                <li>
                  <a href="/songs/ #{ song.id }">
                    <i class="i"></i>
                    Show Details
                  </a>
                </li>
              </ul>
            </div>
            """;
  return string;