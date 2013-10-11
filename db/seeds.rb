# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# POSTS

p = Post.new(:post_type => "link", :user_id => 1, :title => "Florida is da bomb", :status => "live", :upvotes => 25, :downvotes => 1, :spam_count => 1, :post_id => nil, :link => "http://espn.go.com")
p.save!
p.score = p.current_score
p.save!

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
	post.post_id = (1..Post.count).to_a.sample
	post.post_id -= 1 if post.post_id == post.id
	post.save!
	p "Created a #{post.post_type}"
end



# TOPICS

Topic.create(topic_name: "NCAA FOOTBALL", user_id: 1, featured: true)

Topic.create(topic_name: "Florida Gators", user_id: 1, featured: true)

Topic.create(topic_name: "Auburn Tigers", user_id: 1, featured: false)

Topic.create(topic_name: "Jadeveon Clowney", user_id: 1, featured: false)



# COMMENTS

c = Comment.create(comment_text: Faker::Company.bs, comment_id: nil, user_id: 1, post_id: 1, upvotes: 14, downvotes: 2, spam_count: 2)
c.score = c.current_score
c.save!

15.times do
	user_id = 1
	comment_text = Faker::Company.catch_phrase
	upvotes = (0..100).to_a.sample
	downvotes = (0..100).to_a.sample
	spam_count = (0..10).to_a.sample
	post_id = (1..Post.count).to_a.sample

	comment = Comment.new(:comment_text => comment_text, :user_id => user_id, :upvotes => upvotes, :downvotes => downvotes, :spam_count => spam_count, :post_id => post_id)

	comment.save!
	comment.score = comment.current_score
	comment.comment_id = (1..Comment.count).to_a.sample
	comment.comment_id -= 1 if comment.comment_id == comment.id
	comment.save!
	p "Created a comment"
end




