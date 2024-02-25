require 'nokogiri'
require 'open-uri'

url = "https://www.upwork.com/resources/top-sites-for-online-education-and-learning"
# url_local = "E:/files/New Text Document.html"
html_content = File.read(url)

doc = Nokogiri::HTML(html_content)

final_array = []

div_elements = doc.xpath("//div[@style='scroll-margin-top: 150px;']")

div_elements.each_with_index do |div, i|
	# Extract h2 element from the current div
	h2_element = div.at_xpath("h2")
	final_array << h2_element.text if h2_element

	# puts h2_element.text


	p_elements = div.xpath("p")
	p_elements.each { |p| final_array << p.text }

end

final_array[0, 89].each do |e|
	puts e
end