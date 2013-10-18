// Scripts for Stadium Times
$('.carousel').carousel();

// $(window).load(function () {

// });


// SidebarButton: toggle prompt
$(function(){
   $("#sidebarButton").click(function () {
      $(this).text(function(i, text){
          return text === "Join the Conversation" ? "Hide the Conversation" : "Join the Conversation";
      })
   });
})

// Sidebar Comments: get height
// // var h = document.getElementById("site-wrap").offsetHeight;
// var h = window_size = $(window).height();
// document.getElementById("comment-list").style.height = h + "px";

jQuery.event.add(window, "load", resizeFrame);
jQuery.event.add(window, "resize", resizeFrame);

function resizeFrame()
{
    // var h = $(window).height();
    // var w = $(window).width();
    // $("#comment-list").css('height',(h < 768 || w < 1024) ? 500 : 400);
    var h = window_size = $(window).height() - 90;
    document.getElementById("comment-list").style.height = h + "px";
}


// Affix Filter Navbar
$('.filter-navbar#accordian').affix({
  offset: {
    top: 0
  , bottom: function () {
      return (this.bottom = $('#site-footer').outerHeight(true))
    }
  }
})


// Fade Action with Text Change for Reply To
$("#fade-action").click(function(){
  $("#fade-element").toggle('fast');
  $('aside.conversation #fade-element').text(function(i, text){
      return text === "Reply to Conversation" ? "Hide Reply" : "Reply to Conversation";
  })
});

