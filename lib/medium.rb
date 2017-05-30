require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'

BASE_URL = 'https://medium.com/'
BASE_DIR = 'search?q='
SEARCH_MORE = '/search/posts?q='
class Medium


#LOCAL_DIR = 'data-hold/datagov-pages'

#FileUtils.makedirs(LOCAL_DIR) unless File.exists?LOCAL_DIR

# get metainfo from first page:

def get_page_detail tag
  page = Nokogiri::HTML(open(BASE_URL+BASE_DIR + tag))
  blogs = []
  page.css("div.u-paddingTop20").each do |blog|
		content = Hash.new
		content[:author] = blog.css("div.postMetaInline").first.css("a.link--darken").first.text
		content[:time] = blog.css("div.postMetaInline").first.css("time").text
		content[:time_ago] = blog.css("div.postMetaInline").first.css("span.readingTime").last.values.last
		content[:tittle] = blog.css("div.section-inner").first.css("h3").text
		content[:description] = blog.css("div.section-inner").first.css("p").text
		content[:medium_id] = blog.css("div.js-actionRecommend").first.attr("data-post-id")
		content[:link] = blog.css("div.postMetaInline-authorLockup").css("a").last.attr('href')
		blogs << content
	end

	return blogs
end 

def get_blog_detail link
  page = Nokogiri::HTML(open(link))
  html_content = page.css("div.section-inner").to_html
  tags = []
  content = Hash.new
  page.css("ul.tags").first.css("a.link").each do |tag|
    tags << tag.text
  end 
  content[:tags] = tags
  content[:html_content] = html_content
  return content
end

def get_more_page_detail tag,page,ignore_ids
  uri = URI.parse(BASE_URL+BASE_DIR+tag)
  params = {:page => page, :pageSize => 10,ignore: ignore_ids}
   # Add params to URI
   uri.query = URI.encode_www_form(params)
   page = Nokogiri::HTML(open(uri))
  #page = Nokogiri::HTML(open(BASE_URL+BASE_DIR + tag))
  blogs = []
  page.css("div.u-paddingTop20").each do |blog|
		content = Hash.new
		content[:author] = blog.css("div.postMetaInline").first.css("a.link--darken").first.text
		content[:time] = blog.css("div.postMetaInline").first.css("time").text
		content[:time_ago] = blog.css("div.postMetaInline").first.css("span.readingTime").last.values.last
		content[:tittle] = blog.css("div.section-inner").first.css("blockquote").text
		content[:description] = blog.css("div.section-inner").first.css("p").text
		content[:medium_id] = blog.css("div.js-actionRecommend").first.attr("data-post-id")
		content[:link] = blog.css("div.postMetaInline-authorLockup").css("a").last.attr('href')
		blogs << content
	end

	return blogs
end 
# write the HTML for page 1 to disk
#SFile.open("#{LOCAL_DIR}/1.html", 'w'){|f| f.write(page.to_html)}

# last_page_number = page.css("a.end.lastLink.button")[0]['href'].match(/page=(\d+)/)[1].to_i

# puts "Iterating from 2 to #{last_page_number}"

# for pg_number in 2..last_page_number do
#   puts "Getting #{pg_number}"
#   File.open("#{LOCAL_DIR}/#{pg_number}.html", 'w') do |f| 
#     f.write( open("#{BASE_URL}#{BASE_DIR}#{pg_number}").read )
#   end
# end



end 