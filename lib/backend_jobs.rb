class BackendJobs < Struct.new(:blank)

   def perform
     
   end

   def score_posts
    Post.all.each do |p|
      p.delay.update_score
      puts "SCORING POST ID: #{p.id}"
    end
   end

 end