class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|
      t.string :responser_name
      t.string :date
      t.string :read_time
      t.string :desciption
      t.integer :article_id
      t.timestamps
    end
  end
end
