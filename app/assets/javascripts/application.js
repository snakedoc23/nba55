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
//= require_tree .

$(function() {


var cl = new CanvasLoader('loader');
cl.setColor('#ffffff'); // default is '#000000'
cl.setShape('spiral'); // default is 'oval'
cl.setDiameter(193); // default is 40
cl.setDensity(138); // default is 40
cl.setRange(1.2); // default is 1.3
cl.setSpeed(3); // default is 2
cl.setFPS(27); // default is 24
// cl.show(); // Hidden by default


$('body').ajaxStart(function() {
  cl.show();
});
$('body').ajaxComplete(function() {
  cl.hide();
});
  
});
