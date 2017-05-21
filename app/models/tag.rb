class Tag < ApplicationRecord
  has_many :articles, :through => :article_tag
end
