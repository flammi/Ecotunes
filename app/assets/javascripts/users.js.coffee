# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $(".enable-btn").on "click", ->
    alert "enable"
  $(".disable-btn").on "click", ->
    alert "disable"
  $(".delete-btn").on "click", ->
    alert "delete"
  $(".upgrade-btn").on "click", ->
    alert "up"
  $(".downgrade-btn").on "click", ->
    alert "down"
