class Processor
  attr_accessor :blog_search_id,:page,:search_text,:history_search_id

  def fetch_more_blog
  	medium = Medium.new 
  	response = medium.get_more_page_detail search_text,page,ignore_ids
    self.store_blog_info response 
  end

  def store_blog_info response
  	
  end


end
