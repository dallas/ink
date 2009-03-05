# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
	
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '32-character hexidecimal secret'

	helper_method :pretty_post_url, :user_session, :admin?
	
	# Creates "pretty" versions of +post_url+ in the form: /yyyy/m/d/:id-:title.
	def pretty_post_url(post)
		date = [post.post_at, post.created_at].compact.first
		post_permalink_url(:year => date.year, :month => date.month, :day => date.day, :id => post.permalink)
	end
	
	# Access the session data as a "user".
	def user_session
		@user_session ||= UserSession.new(session)
	end
	
	protected
	
	# Check if we are logged in with admin privelages.
	def admin?
		user_session.admin?
	end
	
	# Used as a filter for admin-only actions.
	def authenticate
		unless admin?
			flash[:error] = 'unauthorized access'
			redirect_to home_path
		end
	end
end
