# roman = "MMVIII"
# roman = "MDCLXVI"
roman = ARGV[0] ? ARGV[0] : "MDCLXVI"

unless valid = /^[M]{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$/.match?(roman)
	puts "The input is invalid"
	return
end

values = {"I" => 1,
		"V" => 5,
		"X" => 10,
		"L" => 50,
		"C" => 100,
		"D" => 500,
		"M" => 1000}

result = 0
old_value = 0

roman.each_char do |character|
  new_value = values[character]
  if new_value > old_value
    result = result + new_value - 2 * old_value
  else
  	result = result + new_value
  end

  old_value = new_value
end

puts roman
puts result
=begin
EXPLANATION:
	XI:
		1. result = 10
		2. result = 11
	XIV:
		1. result = 10
		2. result = 11 Here we added 1 to 10, but IV means 5 - 1 = 4
		3. result = 11 + 5(new_value = V) - 2 * 1(old_value = I)
			Here we added V as we needed. IV means 5 - 1, so 
			we subtracted 1. In the 2 step we added this value to the
			result, so we need to subtract this value ones more.
			2 * old_value - describes this steps.
	MCMXC:
		1. result = 1000
		2. result = 1100 We added 100(C). If after this there are 100(C)
			or numbers that less than 100, we just need to add them to the
			result. But if next value is bigger than C, it means that we
			needed to subtract C from the result, not add.
		3. result = 1100 + 500 - 2 * 100 So here we subtract 2 times:
			first - we need to subtract
			second - cancel our addition in the step 2

=end

=begin
OUTPUT:

	1666

=end
