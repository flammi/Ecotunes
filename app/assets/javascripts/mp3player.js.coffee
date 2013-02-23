$(document).ready ->
  $("#jquery_jplayer_1").jPlayer
    ready: ->
      $(this).jPlayer "setMedia",
        mp3: "/musicexplorer/stream_song?filename=fallingdown.mp3"
    swfPath: "/js"
    supplied: "mp3, oga"