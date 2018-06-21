class AddImageToBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_posts, :image, :string
  end
end
