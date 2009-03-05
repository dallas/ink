class TagsController < ApplicationController
	before_filter :check_for_feature # :tags feature must be active
	before_filter :authenticate, # must be admin to do anything but look
									:except => [:index, :show]
	
  # GET /tags
  # GET /tags.xml
  def index
    @tags = Tag.find(:all)

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.xml
  def show
    @tag = Tag.find(params[:id])

    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @tag }
    end
  end

  # GET /tags/new
  # GET /tags/new.xml
  def new
    @tag = Tag.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.xml
  def create
    @tag = Tag.new(params[:tag])

    respond_to do |wants|
      if @tag.save
        flash[:notice] = 'Tag was successfully created.'
        wants.html { redirect_to(@tag) }
        wants.xml  { render :xml => @tag, :status => :created, :location => @tag }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.xml
  def update
    @tag = Tag.find(params[:id])

    respond_to do |wants|
      if @tag.update_attributes(params[:tag])
        flash[:notice] = 'Tag was successfully updated.'
        wants.html { redirect_to(@tag) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.xml
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |wants|
      wants.html { redirect_to(tags_url) }
      wants.xml  { head :ok }
    end
  end

	private
		def check_for_feature
			redirect_to home_path unless admin? || Feature.active?(:tags)
		end
end
