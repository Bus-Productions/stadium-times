module PostsHelper
	def determine_vote_button_class(post_id)
		post_vote = current_user.post_voted_on(post_id)
		if post_vote
			if post_vote.vote == "up"
				@upvote_button_class = "btn small light active"
				@downvote_button_class = "btn small light"
				return
			else
				@upvote_button_class = "btn small light"
				@downvote_button_class = "btn small light active"
				return
			end
		else
			@upvote_button_class = "btn small light"
			@downvote_button_class = "btn small light"
		end
	end
end
