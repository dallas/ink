class AddWebsiteToComments < ActiveRecord::Migration
  def self.up
		add_column :comments, :website, :string
  end

  def self.down
		remove_column :comments, :website
  end
end
