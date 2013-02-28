# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  
  window.onbeforeunload = ->
    localStorage.setItem "playlist", JSON.stringify myPlaylist.playlist
    localStorage.setItem "current", myPlaylist.current
    localStorage.setItem "time", $(".jp-current-time").html()
    localStorage.setItem "paused", $('#jquery_jplayer_1').data().jPlayer.status.paused 

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


#  if localStorage.getItem("current")?
#    myPlaylist.select localStorage.getItem "current"
#    time = localStorage.getItem "current"
#    if localStorage.getItem("paused") == "false"
#      $("#jquery_jplayer_1").jPlayer
#        ready: ->
#          alert "hallo"
#          $('#jquery_jplayer_1').jPlayer("play", time)
#          alert time
#    else 
#      $("#jquery_jplayer_1").jPlayer
#        ready: ->
#          alert "alla"
#          $('#jquery_jplayer_1').jPlayer("pause", time)
#          alert time
      

  $.getJSON("/musicexplorer/search?filter=" + $("#search").val(), {}, (json, resp) -> 
          fillList json, myPlaylist
  );
  $("#search").keyup -> 
    $("#table-content").empty()
    $.getJSON("/musicexplorer/search?filter=" + $("#search").val(), {}, (json, resp) -> 
        fillList json, myPlaylist
    );
  
  $(document).endlessScroll {bottomPixels : 100, ceaseFireOnEmpty: false, fireOnce: false, fireDelay: 10, ceaseFire: (seq, pseq, direction) ->
      if direction is "prev"
        return true
      else
        return false
    callback: (seq, pseq, direction) ->
      $.getJSON "/musicexplorer/search?filter=" + $("#search").val() + "&page=#{pseq+1}" , {}, (json, resp) -> 
        fillList json, myPlaylist
  }
  return


fillList = (jsonString, myPlaylist) ->
  $(jsonString).each (objIndex, obj) ->
    $(obj.songs).each (songIndex, song) ->
          newEntry = $("#row-entry-container").children().clone();
          newEntry.find(".row-track").html("<a href=\"/songs/#{song.id}\" class=\"btn btn-link\">" + song.title + "</a>")
          if song.artist != null
            newEntry.find(".row-artist").html("<a href=\"/artists/#{song.artist.id}\" class=\"btn btn-link\">" + song.artist.name + "</a>")
          newEntry.find(".row-time").text(song.duration)
          if song.album != null
            newEntry.find(".row-album").html("<a href=\"/albums/#{song.album.id}\" class=\"btn btn-link\">#{song.album.name}</a>")
          
          newEntry.find(".row-buttons").find(".play-btn").on "click", ->
            myPlaylist.clear()
            $("#jquery_jplayer_1").jPlayer "setMedia", {mp3: "http://localhost:3000#{song.url}"}
            $("#jquery_jplayer_1").jPlayer "play"
            $("#song-description").text song.title
          
          newEntry.find(".row-buttons").find(".addtoplay-btn").on "click", ->
            myPlaylist.add
              title: song.title
              artist: song.artist.name
              free: true
              mp3: "http://localhost:3000#{song.url}"
            
          newEntry.find(".row-buttons").find(".search-btn").attr("href", "/songs/ #{song.id}")
          $("#table-content").append(newEntry)
          
          newEntry.find(".row-buttons").find(".playlist-button").on "click", ->
            addSongToPlaylist $(this).data("playlistid"), song.id
  #Activate tooltips
  $(".has-tooltip").tooltip()



addSongToPlaylist = (playlistid, songid) ->
  $.post("/playlists/newsong", songid: "#{songid}", playlistid: "#{playlistid}"
    ).done((data) ->
      #$("#alert-info").opacity = 1 #pruefen ob code 200 zurueckkam
      #$("#alert-info").delay(2200).fadeOut(300);
    ).error ->
      #$("#alert-error").opacity = 1 #pruefen ob code 200 zurueckkam
      #$("#alert-error").delay(2200).fadeOut(300);

