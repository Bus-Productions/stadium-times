# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# POSTS

15.times do
	post_type = ["link", "long"].sample
	user_id = 1
	title = Faker::Company.catch_phrase
	text = Faker::Lorem.paragraphs
	status = ["live", "draft", "deleted"].sample
	upvotes = (0..100).to_a.sample
	downvotes = (0..100).to_a.sample
	spam_count = (0..10).to_a.sample

	post = Post.new(:post_type => post_type, :user_id => user_id, :title => title, :status => status, :upvotes => upvotes, :downvotes => downvotes, :spam_count => spam_count)

	if post.post_type == "link"
		post.link = "http://espn.go.com"
	else
		post.text = text
	end
	post.save!
	post.score = post.current_score
	post.post_id = (0..Post.count).to_a.sample
	post.post_id -= 1 if post.post_id == post.id
	post.save!
	p "Created a #{post.post_type}"
end


