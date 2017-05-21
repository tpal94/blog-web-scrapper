class CreateSearchHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :search_histories do |t|
      t.string :search
      t.integer :blog_search_id

      t.timestamps
    end
  end
end
