class SessionsController < ApplicationController
	
	# Login screen
	def new
		# redirect us home if we're already logged in
		redirect_to home_path unless session[:password].blank?
	end
	
	# Login
  def create
		session[:password] = params[:password]
		if admin?
			flash[:notice] = 'Successfully logged in.'
			redirect_to home_path
		else
			session[:password] = nil
			flash.now[:error] = 'Incorrect password.'
			render :action => 'new'
		end
  end

	# Logout
  def destroy
		reset_session
		flash[:notice] = 'Successfully logged out'
		redirect_to home_path
  end
end
