module CommentsHelper
	def comment_date(comment)
		comment.created_at.strftime('<p class="comment_created_at"><span class="month">%b</span> <span class="day">%d</span> <span class="year">%Y</span></p>')
	end
end
