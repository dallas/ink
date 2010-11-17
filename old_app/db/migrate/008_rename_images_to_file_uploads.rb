class RenameImagesToFileUploads < ActiveRecord::Migration
  def self.up
		rename_table(:images, :file_uploads)
  end

  def self.down
		rename_table(:file_uploads, :images)
  end
end
