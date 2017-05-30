class SearchHistory < ApplicationRecord
	belongs_to :blog_search
  
	def get_blog_search page
  	if self.is_fetching_required? page
  	  processor = Processor.new
      processor.page = page 
      processor.blog_search_id = blog_search_id
      processor.history_search_id = id 
      processor.search_text = search
      processor.fetch_more_blog      
    end
    return Article.where(id: self.blog_search.blogs_id)
  end

  def is_fetching_required? page
  	!self.blog_search.blogs_id.size.between?((page.to_i-1)*10, page.to_i*10)  
  end
end
