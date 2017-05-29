class AddHtmlContextToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :htmlcontext, :text
  end
end
