class CreateBlogSearches < ActiveRecord::Migration[5.1]
  enable_extension "hstore"
  def change
    create_table :blog_searches do |t|
      t.string :text
      t.text :blogs_id
      t.timestamps
    end
  end
end
