class Post < ActiveRecord::Base
	has_and_belongs_to_many :tags
	has_many :comments
	has_many :images, :class_name => 'FileUpload'
	validates_presence_of :title, :body
	after_create :update_associated_images
	
	named_scope :live, :conditions => ["deleted = 'f' AND post_at IS NOT NULL"], :order => 'posts.post_at DESC'
	
	attr_accessor :temp_id
	attr_accessor :save_for_later
	
	def photos=(*files)
		for file in files
			FileUpload.new(file)
		end
	end
	
	def permalink
		[id, title.gsub(/[^a-z0-9\s]+|&[a-z0-9]+;/i, '').gsub(/\s+/,'-')].join('-')
	end
	
	def teaser
		helpers.strip_links(RedCloth.new(helpers.truncate(body, 300, '&hellip;')).to_html)
	end
	
	def textilized_title
		helpers.textilize_without_paragraph(title)
	end
	
	def textilized_body(first_paragraph = true)
		output = RedCloth.new(body).to_html
		return output unless first_paragraph
		output.split('<p>', 2).join('<p class="first_paragraph">')
	end
	
	def save_for_later!
		self.save_for_later = true
		update_attribute(:post_at, nil)
	end
	
	def post_now!
		self.save_for_later = false
		update_attribute(:post_at, Time.now)
	end
	
	def destroy
		update_attribute :deleted, true
		return self
	end
	alias_method :delete!, :destroy
	
	def undestroy
		update_attribute :deleted, false
		return self
	end
	alias_method :undelete!, :undestroy
	
	private
	
	def update_associated_images
		FileUpload.find_all_by_post_id(self.temp_id).each {|f| f.update_attribute(:post_id, self.id)}
	end
	
	def helpers
		ActionController::Base.helpers
	end
end
