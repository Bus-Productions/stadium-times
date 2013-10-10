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
var h = document.getElementById("content-wrap").offsetHeight;
document.getElementById("comment-list").style.height = h + "px";


// Affix
 $('.filter-navbar#accordian').affix({
    offset: {
      top: 0
    , bottom: function () {
        return (this.bottom = $('#site-footer').outerHeight(true))
      }
    }
  })