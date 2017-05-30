class Article < ApplicationRecord
  belongs_to :author
  has_and_belongs_to_many :tags
  has_many :responses

  
  self.per_page = 10
  
  def timestamp
  	created_at.strftime('%d %B %Y %H:%M:%S')
  end

end
