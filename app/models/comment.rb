class Comment < ActiveRecord::Base
	belongs_to	:post,
								:counter_cache => true
	validates_presence_of	:post_id, :name, :body
	validates_format_of	:email,
												:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
												:allow_nil => true,
												:unless => Proc.new {|comment| comment.email.blank?}	
	validates_format_of	:website,
												:with => /\A([-a-z0-9]+\.)+[a-z]{2,}(?:\/.*)?\Z/i,
												:allow_nil => true,
												:unless => Proc.new {|comment| comment.email.blank?}
	
	def textilized_body
		RedCloth.new(body).to_html
	end
	
	def website_url
		"http://#{self[:website].strip.sub(/^http:\/\//, '')}"
	end
end
