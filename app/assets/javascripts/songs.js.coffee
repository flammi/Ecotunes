# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

fileUploadErrors = {
  maxFileSize: 'Datei ist zu gross',
  minFileSize: 'Datei ist zu klein',
  acceptFileTypes: 'Der Datentyp ist nicht erlaubt (nur .mp3)',
  maxNumberOfFiles: 'Zuviele Dateien',
  uploadedBytes: 'Uploaded bytes exceed file size',
  emptyResult: 'Empty file upload result'
  }

$ ->
  # Initialize the jQuery File Upload widget:
  $("#fileupload").fileupload
    acceptFileTypes: /(\.|\/)(mp3|MP3)$/i
  
  # Load existing files:
  $.getJSON $("#fileupload").prop("action"), (files) ->
    fu = $("#fileupload").data("fileupload")
    template = undefined
    fu._adjustMaxNumberOfFiles -files.length
    template = fu._renderDownload(files).appendTo($("#fileupload .files"))
    
    # Force reflow:
    fu._reflow = fu._transition and template.length and template[0].offsetWidth
    template.addClass "in"
    $("#loading").remove()

