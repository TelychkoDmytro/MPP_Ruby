def generate_abbreviations(words)
  word_list = words.split
  
  abbreviations = []

  word_list.each do |word|
    abbreviation = word[0].upcase
    abbreviations << abbreviation
  end
  abbreviations.join
end

puts "Enter text"
input_words = ARGV[0] ? ARGV[0] : "Test text for abbreviations"
input_words

abbreviations = generate_abbreviations(input_words)
puts "Abreviation: #{abbreviations}"
