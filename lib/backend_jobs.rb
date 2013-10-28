class BackendJobs < Struct.new(:blank)

   def perform
     
   end

   def score_posts
    Post.live.each do |p|
      p.delay.update_score
      puts "SCORING POST ID: #{p.id}"
    end
   end

   def score_comments
    Comment.each do |c|
      c.delay.update_score
      puts "SCORING COMMENT ID: #{c.id}"
    end
   end

 end