module PostsHelper
	def determine_target(post)
		post.link ? "_blank" : ""
	end
end
