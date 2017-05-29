class FetchBlogDetailJob < ApplicationJob
  queue_as :default

  def perform(articles,blog_search)
  	medium = Medium.new
  	articles.each do |article|
     response = medium.get_blog_detail article.link
     article.update_attributes(htmlcontext: response[:html_content])
     response[:tags].each do |tag|
     	article.tags.create(name: tag)
     end 
    end 
    # Do something later
  end
end
