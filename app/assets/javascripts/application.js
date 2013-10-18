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
	 	var post_route = $(this).closest(".post_vote").attr("id").split("_");
		var post_id = post_route[1];
		$.post("post_votes/" + post_id + "/up", function(){
		});
	});

	$('.post_vote').on("click", ".post_vote_down", function(e){
		e.preventDefault(); 
	 	$(this).addClass("active");
	 	$(this).siblings(".post_vote_up").removeClass("active"); 
	 	var vote_count = parseInt($(this).text());
	 	var changed = vote_count + 1
	 	$(this).html("<span class='ss-dislike'></span>" + changed.toString());
 	 	var post_route = $(this).closest(".post_vote").attr("id").split("_");
 		var post_id = post_route[1];
 		$.post("post_votes/" + post_id + "/down", function(){
 		});
	});
});
	