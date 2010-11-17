class FileUploadsController < ApplicationController
	before_filter :authenticate, # must be admin to do anything but look
									:except => :show
	
  # GET /file_uploads
  # GET /file_uploads.xml
  def index
    @file_uploads = FileUpload.find(:all)

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @file_uploads }
    end
  end

  # GET /file_uploads/1
  # GET /file_uploads/1.xml
  def show
    @file_upload = FileUpload.find(params[:id])

    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @file_upload }
    end
  end

  # GET /file_uploads/new
  # GET /file_uploads/new.xml
  def new
    @file_upload = FileUpload.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @file_upload }
    end
  end

  # POST /file_uploads
  # POST /file_uploads.xml
  def create
    @file_upload = FileUpload.new(params[:file_upload])

    respond_to do |wants|
      if @file_upload.save
        flash[:notice] = 'File was successfully uploaded.'
        wants.html { redirect_to(@file_upload) }
        wants.xml  { render :xml => @file_upload, :status => :created, :location => @file_upload }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @file_upload.errors, :status => :unprocessable_entity }
      end
			wants.js { responds_to_parent do; render :action => 'create', :layout => false; end }
    end
  end

  # DELETE /file_uploads/1
  # DELETE /file_uploads/1.xml
  def destroy
    @file_upload = FileUpload.find(params[:id])
    @file_upload.destroy

    respond_to do |wants|
      wants.html { redirect_to(file_uploads_url) }
      wants.xml  { head :ok }
    end
  end
end
