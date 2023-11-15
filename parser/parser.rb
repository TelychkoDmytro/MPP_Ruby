require 'nokogiri'
require 'httparty'
require 'csv'

url = 'https://www.hospitalsafetygrade.org/all-hospitals'

response = HTTParty.get(url)
doc = Nokogiri::HTML(response.body)

# Знаходження та виведення назв лікарень з індексами
hospitals = doc.css('div#BlinkDBContent_849210 ul li a')

# Запис у CSV файл
CSV.open('hospitals_list.csv', 'w') do |csv|
  csv << ['Index', 'Hospital Name'] # Записати заголовок

  hospitals.each_with_index do |hospital, index|
    csv << ["#{index + 1}", hospital.text.strip]
  end
end

puts "Data has been written to 'hospitals_list.csv' file."
