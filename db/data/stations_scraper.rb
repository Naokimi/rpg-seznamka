require 'Nokogiri'

tyo = Rails.root.join('db', 'data', 'stations', 'tyo_stations.html')
chiba = Rails.root.join('db', 'data', 'stations', 'chiba_stations.html')
kanagawa = Rails.root.join('db', 'data', 'stations', 'kanagawa_stations.html')
saitama = Rails.root.join('db', 'data', 'stations', 'saitama_stations.html')
yamanashi = Rails.root.join('db', 'data', 'stations', 'yamanashi_stations.html')

ALL_HTML = [
  ['Tokyo', tyo],
  ['Chiba', chiba],
  ['Kanagawa', kanagawa],
  ['Saitama', saitama],
  ['Yamanashi', yamanashi]
]

def scraper
  stations = []
  ALL_HTML.each do |area|
    hash = {}
    hash[:prefecture] = area[0]
    hash[:stations] = []

    html_file = File.open(area[1]).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('.mw-category-group').each do |div|
      div.search('li').each do |li|
        hash[:stations].push(li.content)
      end
    end
    stations.push(hash)
  end
  stations
end
