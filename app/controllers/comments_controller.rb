class CommentsController < ApplicationController
	before_filter :check_for_feature # :comments feature must be active
	before_filter :find_post, # find the relevant @post object
									:except => [:edit, :update, :destroy]
	before_filter :check_ownership, # we must own the things we edit
									:only => [:edit, :update]
	before_filter :authenticate, # only admin may delete
									:only => :destroy
	
  # GET /posts/:post_id/comments
  # GET /posts/:post_id/comments.xml
  def index
		redirect_to pretty_post_url(@post) + '#comments'
  end

  # GET /posts/:post_id/comments/1
  # GET /posts/:post_id/comments/1.xml
  def show
    redirect_to pretty_post_url(@post) + "#comment_#{params[:id]}"
  end

  # GET /posts/:post_id/comments/new
  # GET /posts/:post_id/comments/new.xml
  def new
    respond_to do |wants|
      wants.html { redirect_to pretty_post_url(@post) + '#comments' }
      wants.xml  { render :xml => @comment }
    end
  end

  # POST /posts/:post_id/comments
  # POST /posts/:post_id/comments.xml
  def create
    @comment = @post.comments.build(params[:comment])

    respond_to do |wants|
      if @comment.save
				user_session.add_comment(@comment)
        flash[:notice] = 'Comment was successfully created.'
				flash[:comment_saved] = true
        wants.html { redirect_to pretty_post_url(@post) + "#comment_#{@comment.id}" }
        wants.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
				# @new_comment = true
				flash[:comment_params] = params[:comment]
				flash[:comment_error] = @comment.errors.full_messages.join('<br />')
        wants.html { redirect_to pretty_post_url(@post) + '#add_comment' } # { render :template => 'posts/show', :section => 'comments' }
        wants.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |wants|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        wants.html { redirect_to pretty_post_url(@comment.post) + "#comment_#{@comment.id}" }
        wants.xml  { head :ok }
      else
        wants.html { render :action => 'edit' }
        wants.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
		post = @comment.post
    @comment.destroy

    respond_to do |wants|
      wants.html { redirect_to pretty_post_url(post) + '#comments' }
      wants.xml  { head :ok }
    end
  end

	private	
		# Finds the relevant @post object.
		def find_post
			@post = Post.find(params[:post_id])
		end
	
		def check_ownership
			unless user_session.can_edit_comment? Comment.find(params[:id])
				flash[:error] = 'You are no longer able to edit this comment.'
				redirect_to home_path
			end
		end
	
		def check_for_feature
			redirect_to home_path unless admin? || Feature.active?(:comments)
		end
end
