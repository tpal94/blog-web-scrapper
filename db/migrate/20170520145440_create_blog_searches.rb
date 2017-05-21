class CreateBlogSearches < ActiveRecord::Migration[5.1]
  enable_extension "hstore"
  def change
    create_table :blog_searches do |t|
      t.string :text
      t.hstore :blogs_id, array: true
      t.timestamps
    end
  end
end
