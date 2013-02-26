// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery_ujs
//= require jquery-fileupload
//= require_tree ./global

jQuery(function() {
    jQuery('#search').focus(function() {
        jQuery(this).animate({ width: '236px'});
    }).blur(function() {
        jQuery(this).animate({ width: '100px'});
    });

    jQuery('#close-open').click(function() {
      if ($('#close-open').hasClass("is-open")){
        $('#close-open').removeClass("is-open").addClass("is-closed");
        $('#close-open').text(" Open ");
        $('#close-open').append('<i class="icon-chevron-up"></i>');

        $('#player').slideUp("slow");
      }else{
        $('#close-open').removeClass("is-closed").addClass("is-open");
        $('#close-open').text(" Close ");
        $('#close-open').append('<i class="icon-chevron-down"></i>');
        $('#player').slideDown("slow");
      }
    });
});