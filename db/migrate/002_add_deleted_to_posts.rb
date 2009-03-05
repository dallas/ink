class AddDeletedToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :deleted, :boolean, :default => false
		
		Post.find(:all, :conditions => { :deleted => nil }).each {|post| post.deleted = false; post.save}
  end

  def self.down
    remove_column :posts, :deleted
  end
end
