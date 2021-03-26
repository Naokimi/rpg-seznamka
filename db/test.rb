require 'open-uri'
require 'nokogiri'

ingredient = 'chocolate'
url = "https://rpggeek.com/browse/rpggenre"

html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)


puts html_doc
