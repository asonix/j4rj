// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

toggled = false;

window.onscroll = function() {
  if ($(document).scrollTop() == 0) {
    $("header").toggleClass("header-top");
    toggled = false;
  } else if (toggled == false) {
    $("header").toggleClass("header-top");
    toggled = true;
  }
}

var ready = function() {
  $("body").on('click', '.page-title', function(evt) {
    evt.preventDefault();
    var title = $(this).html();
    var id = $(this).attr('data-id');
    console.log(title, id);

    $("#dropdownMenu1").find('#selected').html(title);
    $("#dropdownMenu1").find('#selected').attr('data-id', id);
    $("#dropdownMenu1").find('input[type=hidden]').val(id);
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);
