module PostsHelper
	
	def date_of_post(post)
		date = [post.post_at, post.created_at].compact.first
		date.strftime('
			<h6><span class="year">%Y</span></h6>
			<h4><span class="month">%b</span> <span class="day">%d</span></h4>
		')
	end
	
	def post_tags_links(post)
		content = []
		for tag in post.tags
			content << link_to(tag.name.titleize, tag)
		end
		return content.join(', ')
	end
end
