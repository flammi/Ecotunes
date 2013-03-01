# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $(".enable-btn").on "click", ->
    userid = $(this).closest(".button-container").data("userid")
    $.post("/users/activate_user", user_id: "#{userid}").done((data) ->
      #handling

      ).error ->
  $(".disable-btn").on "click", ->
    userid = $(this).closest(".button-container").data("userid")
    $.post("/users/deactivate_user", user_id: "#{userid}").done((data) ->
      #handling
      ).error ->
  $(".delete-btn").on "click", ->
    tr = $(this).closest("tr")
    userid = $(this).closest(".button-container").data("userid")
    $.post("/users/remove_user", user_id: "#{userid}"
    ).done((data) ->
      tr.remove()
      ).error ->
  $(".upgrade-btn").on "click", ->
    userid = $(this).closest(".button-container").data("userid")
    $.post("/users/upgrade_user", user_id: "#{userid}").done((data) ->
      #handling
      ).error ->
  $(".downgrade-btn").on "click", ->
    userid = $(this).closest(".button-container").data("userid")
    $.post("/users/downgrade_user", user_id: "#{userid}").done((data) ->
      #handling
      ).error ->
    
  #Activate tooltips
  $(".has-tooltip").tooltip()