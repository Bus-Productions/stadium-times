module PostsHelper
	def determine_target(post)
		post.link ? "_blank" : ""
	end

	def return_options_for_topics(topics)
		topics.inject([])
	end
end	
