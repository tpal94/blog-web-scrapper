class SearchHistory < ApplicationRecord
	belongs_to :blog_search



	def get_blog_search page
  	if self.is_fetching_required? page
  	  processor = Processor.new(page: page,blog_search_id: blog_search_id,history_search_id: id,search_text: search)
      processor.fetch_more_blog      
    end
    return Article.where(id: self.blog_search.blogs_id)
  end

  def is_fetching_required?
  	!self.blog_search.blogs_id.size.between?((page-1)*10, page*10)  
  end
end
