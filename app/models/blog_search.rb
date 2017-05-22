class BlogSearch < ApplicationRecord
  has_many :search_histories
  serialize :blogs_id, Array

end
