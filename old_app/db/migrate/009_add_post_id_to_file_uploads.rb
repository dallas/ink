class AddPostIdToFileUploads < ActiveRecord::Migration
  def self.up
		add_column :file_uploads, :post_id, :integer
  end

  def self.down
		remove_column :file_uploads, :post_id
  end
end
