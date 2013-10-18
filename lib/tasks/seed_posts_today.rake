namespace :db do
   desc "Add posts for today"
   task :seed_today => :environment do
     16.times do
     	post_type = ["link", "text"].sample
     	user_id = 1
     	title = Faker::Company.catch_phrase
     	text = Faker::Lorem.paragraphs
     	status = "live"
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
   end
end