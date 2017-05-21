json.extract! article, :id, :tittle, :description, :link, :medium_id, :author_id, :date, :time_ago, :tag_id, :created_at, :updated_at
json.url article_url(article, format: :json)
