// Scripts for Stadium Times

$(document).ready(function(){

  $('.ss-search').on("click", function(e){
    $.post("/posts/search", function(){
      $('#search').val("");
    });
  });

  $('.main').on("click", ".post_vote_up", function(e){
    e.preventDefault(); 
    $(this).addClass("active");
    $(this).next(".post_vote_down").removeClass("active"); 
    var vote_count = parseInt($(this).text());
    var changed = vote_count + 1;
    $(this).html("<span class='ss-like'></span>" + changed.toString());
  });

});


$(function() {
  if ($('.pagination').length) {
      $(window).scroll(function() {
        var url = $('.pagination .next_page').attr('href');
        if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
          $('.pagination').html("Fetching more results...");
          return $.getScript(url);
        }
      });
    }
    return $(window).scroll();
});

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


$('#comment-list').bind('mousewheel', function (e) {

    $(this).scrollTop($(this).scrollTop() - e.originalEvent.wheelDeltaY);

    //prevent page fom scrolling
    return false;

});

$('#new-comment-button').hide();
$('.new-comment-box').focus(function(){
  $('#new-comment-button').show();
});

function limitCommentCharacters(element) {
  var text = element.val();
  console.log(text);
  console.log(text.length);
  if (text.length > 200) {
    element.val(text.substr(0,200));
  };
}

function setCommentTextBehavior() {
  // Fade Action with Text Change for Reply To
  $(".comment-reply-text").click(function(){
    $('.comment-reply-text').show();
    $(this).hide();
    var comment_id = $(this).attr('commentid');
    $(".reply-to").hide();
    $(".comment-"+comment_id+"#new_comment").toggle('fast');
    // $('aside.conversation #fade-element').text(function(i, text){
    //     return text === "Reply to Conversation" ? "Hide Reply" : "Reply to Conversation";
    // })
  });

  $(".in-reply-to-comment").click(function(){
    $(this).parent().hide();
    var comment_id = $(this).attr('commentid');
    $("#parent-comment-"+comment_id).removeClass('alpha');
    $("#parent-comment-"+comment_id).before('<div id="comment_waiting_box"></div>');
  });

  $(".reply-submit-button").click(function(){
    var comment_id = $(this).attr('commentid');
    $container = $("#parent-comment-"+comment_id);
    $container.after('<div id="comment_waiting_box"></div>');
    $container.find('textarea').text('');
    $container.find('form').hide();
    $container.find('.comment-reply-text').show();
  });

  $("#new-comment-button").click(function(){
    $('#comments-container').prepend('<div id="comment_waiting_box"></div>');
  });

 $('.comment-area').bind('keypress', function() {var text = $(this).val();if (text.length==200) {return false;} else {return true;}});

  $('.comment-area').change(function(){
    limitCommentCharacters($(this));
  });
  $('.comment-area').keyup(function(){
    limitCommentCharacters($(this));
  });
}
setCommentTextBehavior();

