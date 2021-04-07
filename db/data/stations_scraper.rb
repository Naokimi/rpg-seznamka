require 'Nokogiri'
require 'open-uri'
require_relative 'stations_html_file/chiba_stations.html'
require_relative 'stations_html_file/kanagawa_stations.html'
require_relative 'stations_html_file/saitama_stations.html'
require_relative 'stations_html_file/tyo_stations.html'
require_relative 'stations_html_file/yamanashi_stations.html'

STATIONS = []

HTMLS = [
  ['Tokyo', 'tyo_stations.html'],
  ['Chiba', 'chiba_stations.html'],
  ['Kanagawa', 'kanagawa_stations.html'],
  ['Saitama', 'saitama_stations.html'],
  ['Yamanashi', 'yamanashi_stations.html']
]

def scrape
  HTMLS.each do |area|
    hash = {}
    hash[:prefecture] = area[0]
    hash[:stations] = []
    html = area[1]
    html_file = open(html).read
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.mw-category-group').each do |div|
      div.search('li').each do |li|
        hash[:stations].push(li.content)
      end
    end
    STATIONS.push(hash)
  end
end

scrape
