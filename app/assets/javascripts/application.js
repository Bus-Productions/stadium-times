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

$(document).ready(function(){

	$('.ss-search').on("click", function(e){
		$.post("/posts/search", function(){
			$('#search').val("");
		});
	});

	$('.post_vote').on("click", ".post_vote_up", function(e){
	 	e.preventDefault(); 
	 	$(this).addClass("active");
	 	$(this).next(".post_vote_down").removeClass("active"); 
	 	var vote_count = parseInt($(this).text());
	 	var changed = vote_count + 1;
	 	$(this).html("<span class='ss-like'></span>" + changed.toString());
	});

	$('.post_vote').on("click", ".post_vote_down", function(e){
		e.preventDefault(); 
	 	$(this).addClass("active");
	 	$(this).siblings(".post_vote_up").removeClass("active"); 
	 	var vote_count = parseInt($(this).text());
	 	var changed = vote_count + 1
	 	$(this).html("<span class='ss-dislike'></span>" + changed.toString());
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
	