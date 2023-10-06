def find_ones(array)
  ones = []
  array.each_with_index do |row, row_index|
    row.each_with_index do |value, col_index|
      ones << [row_index, col_index] if value == 1
    end
  end
  return ones
end

def print_matrix(matrix)
  matrix.each do |row|
    row.each do |element|
      print "#{element} "
    end
  puts
  end
end

def print_matrix_3d(matrix3d)
  matrix3d.each do |matrix|
    print_matrix(matrix)
    puts
  end
end

def print_matrix_4d(matrix4d, delimiters = "")
  count = 1
  matrix4d.each do |matrix3d|
    puts "#{delimiters}| #{count}"
    print_matrix_3d(matrix3d)
    count = count + 1
  end
  puts "#{delimiters}| End"
end

# Test to split matrix by rows
def split_matrix_rows(matrix, rows)
  max_ind = matrix.length - 1
  splits = []

  start_index = 0

  # Split by rows
  unless rows.empty?
    rows.each do |i|
      if i < max_ind
      last_index = i + 1
      splits << matrix[start_index...last_index]
      start_index = last_index
    end
    end
  end

  # Write the last part that remains
  splits << matrix[start_index..-1] if start_index < matrix.length

  splits
end

# Test to split matrix by cols
def split_matrix_cols(matrix, cols)
  splits = []

  start_index = 0

  unless cols.empty?
    cols.each do |i|
      last_index = i + 1
      column = matrix.map { |col| col[start_index...last_index] } # Extract the i-th column
      splits << column
      start_index = last_index
    end
  end

  # Write the last part that remains
  splits << matrix.map { |col| col[start_index..-1] } if start_index < matrix[0].length

  splits
end

def split_matrix(matrix, rows, cols)
  splits_by_rows = []
  splits = []

  start_index = 0

  # Spliting by rows
  unless rows.empty?
    rows.each do |i|
      last_index = i + 1
      splits_by_rows << matrix[start_index...last_index]
      start_index = last_index
    end
  end

  # Write the last part that remains
  splits_by_rows << matrix[start_index..-1] if start_index < matrix.length

  # Spliting by columns
  unless cols.empty?
    splits_by_rows.each do |array|
      start_index = 0
      cols.each do |i|
        last_index = i + 1
        column = array.map { |col| col[start_index...last_index] } # Extract the i-th column
        splits << column
        start_index = last_index
      end
      splits << array.map { |col| col[start_index..-1] } if start_index < array[0].length
    end
  else
    splits = splits_by_rows.dup
  end

  splits
end

def one_resin_per_piece?(matrix3d)
  matrix3d.each do |matrix|
    count = 0
    matrix.each do |array|
      array.each do |element|
        count = count + 1 if element == 1
      end
    end
    return false unless count == 1
  end
  return true
end

def equale_forms?(matrix3d)
  square = matrix3d.first.flatten.length
  matrix3d.each do |matrix|
    return false unless matrix.flatten.length == square
  end
  return true
end

def generate_combinations(arr, prefix = [])
  combinations = []

  if arr.empty?
    combinations << prefix.dup
  else
    combinations += generate_combinations(arr[1..-1], prefix + [arr[0]])
    combinations += generate_combinations(arr[1..-1], prefix)
  end

  return combinations
end

def print_result(matrix3d)
  length = 0
  ind = 0
  if matrix.empy?
    puts "There is no result"
    return
  end
  matrix3d.each do |matrix|
    if matrix.first.first.length > length
      length = matrix.first.first.length  
      ind = matrix3d.index(matrix)
    end
  end
  print_matrix_3d(matrix3d[ind])
end


num_of_rows = 4
num_of_cols = 8
# Create pie
matrix = Array.new(num_of_rows) { Array.new(num_of_cols) {0} }

#Fill with risens
random = false
if random == true
  5.times do |i|
    matrix[rand(num_of_rows)][rand(num_of_cols)] = 1
  end
else
  matrix[0][1] = 1
  matrix[1][6] = 1
  matrix[2][4] = 1
  matrix[3][2] = 1
end

# Print pie with risens
puts "Array"
print_matrix(matrix)
puts "Coords of resins"
ones = find_ones(matrix)
puts
print_matrix(ones)
puts "\n\n"

splits = []
rows = (0..matrix.length - 1).to_a
cols = (0..matrix[0].length - 1).to_a
rows.pop()
cols.pop()

com1 = generate_combinations(rows)
com2 = generate_combinations(cols)
# puts "combinations1"
# print_matrix(com1)
# puts "combinations2"
# print_matrix(com2)

com1.each do |var1|
  com2.each do |var2|
    split = split_matrix(matrix, var1, var2)
    if one_resin_per_piece?(split) and equale_forms?(split)
      # puts "#{var1}/#{var2}"
      splits << split
    end
  end
end

# split = split_matrix_rows(matrix, rows)
# split = split_matrix_cols(matrix, cols)
# split = split_matrix(matrix, rows, cols)
# split = split_matrix(matrix, [0, 2], [1])
# print_matrix_3d(split)
# print_matrix_4d(splits, "========")
print_result(splits)
# puts one_resin_per_piece?(split)

=begin
 Output

Array
0 1 0 0 0 0 0 0
0 0 0 0 0 0 1 0
0 0 0 0 1 0 0 0
0 0 1 0 0 0 0 0

Result
0 1 0 0 0 0 0 0

0 0 0 0 0 0 1 0

0 0 0 0 1 0 0 0

0 0 1 0 0 0 0 0
=end
