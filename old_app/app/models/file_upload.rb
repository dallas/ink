class FileUpload < ActiveRecord::Base
	has_attachment	:content_type => :image,
									:storage => :file_system,
									:max_size => 5.megabytes,
									:resize_to => '1024x1024>',
									:thumbnails => { :thumb => '154>', :post => '500>' },
									:processor => 'Rmagick',
									:path_prefix => 'public/uploads/'
	
	validates_as_attachment
	
	belongs_to :post
end
