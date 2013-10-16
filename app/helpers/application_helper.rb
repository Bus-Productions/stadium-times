module ApplicationHelper
	include PostsHelper

  def formatted_date(the_date)
   return the_date.strftime('%B %d, %Y')
  end

end
