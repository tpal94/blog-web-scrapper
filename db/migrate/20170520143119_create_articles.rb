class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :tittle
      t.text :description
      t.string :link
      t.string :medium_id
      t.integer :author_id
      t.datetime :date
      t.string :time_ago
      t.timestamps
    end
  end
end
