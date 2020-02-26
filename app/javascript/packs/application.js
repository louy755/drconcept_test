// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('datatables.net-bs4')
require("chartkick")
require("chart.js")


import $ from 'jquery';
global.$ = jQuery;
$(document).ready(function() {
  $('#per').DataTable();
  $('#recs').DataTable();
});


$(document).ready(function() {
  $(function() {
    $('a#show_delivery').click(function(event){
      event.preventDefault();
      $('div#delivery').toggle();
    });
  });
});
$(document).ready(function() {
  $(function() {
    $('a#show_items').click(function(event){
      event.preventDefault();
      $('div#items').toggle();
    });
  });
});
$(document).ready(function() {
  $(function() {
    $('a#show_pays').click(function(event){
      event.preventDefault();
      $('div#pays').toggle();
    });
  });
});
$(document).ready(function() {
  $(".alert" ).fadeOut(5000);
  $(".notice" ).fadeOut(5000);
  $(".error" ).fadeOut(5000);
});
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
