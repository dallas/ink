class UserSession	
	def initialize(session)
		@session = session
		@session[:comment_ids] ||= []
	end
	
	def add_comment(comment)
		@session[:comment_ids] << comment.id
	end
	
	def can_edit_comment?(comment)
		admin? || @session[:comment_ids].include?(comment.id) && comment.created_at > 15.minutes.ago
	end
	
	def admin?
		@session[:password] == PASSWORD
	end
end
