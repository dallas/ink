class AddPostAtToPosts < ActiveRecord::Migration
  def self.up
		add_column :posts, :post_at, :datetime
		
		Post.find(:all, :conditions => { :post_at => nil }).each {|post| post.post_at = post.created_at; post.save}
  end

  def self.down
		remove_column :posts, :post_at
  end
end
