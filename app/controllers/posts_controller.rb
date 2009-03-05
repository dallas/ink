class PostsController < ApplicationController
	before_filter :authenticate, # must be admin to do anything but look
									:except => [:index, :show]
	
	# GET /posts
	# GET /posts.xml
	def index
		@posts = Post.live.all#(:include => :tags)

		respond_to do |wants|
			wants.html # index.html.erb
			wants.xml	{ render :xml => @posts }
			wants.atom # index.atom.builder
		end
	end

	# GET /posts/1
	# GET /posts/1.xml
	def show
		@post = Post.find(params[:id])
		
		if Feature.active? :comments
			@comments	= @post.comments.all(:order => 'created_at')
			@comment	= Comment.new(params[:comment] || flash[:comment_params])
			@comment_saved = flash[:comment_saved]
		end

		respond_to do |wants|
			wants.html # show.html.erb
			wants.xml	{ render :xml => @post }
		end
	end

	# GET /posts/new
	# GET /posts/new.xml
	def new
		@post = Post.new(:temp_id => Time.now.to_i) # temp_id to link file_uploads

		respond_to do |wants|
			wants.html # new.html.erb
			wants.xml	{ render :xml => @post }
		end
	end

	# POST /posts
	# POST /posts.xml
	def create
		@post = Post.new(params[:post])

		respond_to do |wants|
			if @post.save
				flash[:notice] = 'Post was successfully created.'
				wants.html { redirect_to pretty_post_url(@post) }
				wants.xml	{ render :xml => @post, :status => :created, :location => @post }
			else
				flash.now[:post_error] = @post.errors.full_messages.join('<br />')
				wants.html { render :action => 'new' }
				wants.xml	{ render :xml => @post.errors, :status => :unprocessable_entity }
			end
		end
	end

	# GET /posts/1/edit
	def edit
		@post = Post.find(params[:id])
	end

	# PUT /posts/1
	# PUT /posts/1.xml
	def update
		@post = Post.find(params[:id])

		respond_to do |wants|
			if @post.update_attributes(params[:post])
				flash[:notice] = 'Post was successfully updated.'
				wants.html { redirect_to(@post) }
				wants.xml	{ head :ok }
			else
				flash.now[:post_error] = @post.errors.full_messages.join('<br />')
				wants.html { render :action => 'edit' }
				wants.xml	{ render :xml => @post.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /posts/1
	# DELETE /posts/1.xml
	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		
		respond_to do |wants|
			wants.html { redirect_to(posts_url) }
			wants.xml	{ head :ok }
		end
	end
end
