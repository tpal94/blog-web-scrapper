class Processor
  attr_accessor :blog_search_id,:page,:search_text,:history_search_id

  def fetch_more_blog
  	medium = Medium.new 
    blog = BlogSearch.find(blog_search_id)
    ignore_ids = Article.where(id: blog.blogs_id).pluck(:medium_id)
  	responses = medium.get_more_page_detail search_text,page,ignore_ids
    self.store_blog_info responses 
  end

  def store_blog_info responses
  	if responses.present?
       blog_search = BlogSearch.find(self.blog_search_id)
       #Mapping with the current data
       blogs = []
       responses.each do |obj|
       	blog = Hash.new
        blog[:author_id] = Author.find_or_create_by(name: obj[:author]).id
        blog[:date]  = DateTime.parse(obj[:time])
        blog[:tittle],blog[:description],blog[:link],blog[:medium_id] = obj[:tittle],obj[:description],obj[:link],obj[:medium_id]
        blogs << blog 
       end
       articles = Article.create(blogs) 
       blog_search.blogs_id << articles.pluck(:id)
       blog_search.blogs_id = blog_search.blogs_id.uniq
       blog_search.save!
    end 
  end

  def insert_fetched_detail(responses)
    if responses.present?
       
       #blog_search = BlogSearch.find(self.blog_search_id)
       #Mapping with the current data
       blogs = []
       responses.each do |obj|
        blog  = obj.except(:author,:time).clone
        blog[:author_id] = Author.find_or_create_by(name: obj[:author]).id
        blog[:date]  = DateTime.parse(obj[:time])
        blogs << blog 
       end
       binding.pry 
       articles = Article.create(blogs) 
       blog_search = BlogSearch.create(text: self.search_text,blogs_id: articles.pluck(:id))
       history_search = SearchHistory.create(search: self.search_text,blog_search_id: blog_search.id)
       FetchBlogDetailJob.perform_later(articles, blog_search)
       binding.pry
       return articles
    end 
  end


end
