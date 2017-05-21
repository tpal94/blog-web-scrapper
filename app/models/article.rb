class Article < ApplicationRecord
  belongs_to :author
  has_many :responses
  has_many :tags, :through => :article_tag
  self.per_page = 10


  def timestamp
  	created_at.strftime('%d %B %Y %H:%M:%S')
  end

end
