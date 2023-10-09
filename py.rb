def find_ones(array)
  ones = []
  array.each_with_index do |row, row_index|
    row.each_with_index do |value, col_index|
      ones << [row_index, col_index] if value == 1
    end
  end
  ones
end

def print_matrix(matrix)
  matrix.each do |row|
    row.each do |element|
      print "#{element} "
    end
  puts
  end
end

def custom_split(array, indices_or_sections, axis = 0)
  if axis != 0
    raise ArgumentError, "Unsupported axis value, only axis 0 is supported."
  end

  # sections = []
  # start_index = 0



  # indices_or_sections.each do |end_index|
  #   sections << array[start_index...end_index]
  #   start_index = end_index
  # end

  # sections << array[start_index..-1] if start_index < array.length

  # sections



  splits = []
  rows = []
  indices_or_sections.each do |row|
    # puts row[0]
    rows << row[0]
  end
  rows = rows.uniq
  rows.sort()
  puts rows

  n = rows.length
  result = []

  (0..n).each do |i|
    (i + 1..n).each do |j|
      if !rows[j].nil? and rows[i] <= rows[j-1]
        result << [rows[i], rows[j]]
      end
    end
  end



  # indices_or_sections.each_cons(1).uniq do |start_row, end_row|
  #   puts start_row, end_row
  #   split_matrix = array[start_row..end_row]
  #   splits << split_matrix
  # end

  result
end





# Create pie
matrix = Array.new(8) { Array.new(8) {0} }

# Fill with risens
4.times do |i|
  matrix[rand(8)][rand(8)] = 1
end


# Print pie with risens
print_matrix(matrix)

ones = find_ones(matrix)

print_matrix(ones)
puts "\n\n\n"



# Example usage:
original_array = matrix
indices = [2]
axis = 0
# puts indices, axis
result = custom_split(original_array, ones, axis)

result.each_with_index do |subarray, index|
  puts "Subarray #{index + 1}: #{subarray}"
end












# matrix.each do |row|
#   row[rand(5)] = 1
# end

#   # Добавляем получившийся подмассив в результат
#   result << subarray
# end

# # Виводим результат
# result.each do |subarray|
#   puts subarray.join(" ")
# end
