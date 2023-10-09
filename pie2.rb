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

# Test to split matrix by rows
def split_matrix_rows(matrix, rows)
  splits = []

  start_index = 0

  # Split by rows
  unless rows.empty?
    rows.each do |i|
      last_index = i + 1
      splits << matrix[start_index...last_index]
      start_index = last_index
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
  count = 0
  matrix3d.each do |row|
    row.each do |element|
      if element == 1
        count = count + 1
      end
    end
  end
  if count == 1
    return true
  else
    return false
  end
  # matrix3d.each do |matrix|
  #   ones = find_ones(matrix)
  #   return false if ones.length > 1
  # end
  # return true
end

# Create pie
matrix = Array.new(3) { Array.new(3) {0} }

#Fill with risens
3.times do |i|
  matrix[rand(3)][rand(3)] = 1
end

# matrix[2][1] = 1
# matrix[1][1] = 1

# Print pie with risens
print_matrix(matrix)
puts

ones = find_ones(matrix)

print_matrix(ones)
puts "\n\n"

# rows = [1]
# cols = [1, 3]

# # Split the matrix by rows
# splits_by_cols = split_matrix_cols(matrix, cols)

# # Holds the final splits
# splits = []

# # Iterate through the submatrices created by splitting rows
# splits_by_cols.each do |submatrix|
#   # Split each submatrix by columns
#   submatrix_splits = split_matrix_rows(submatrix, rows)
  
#   # Add the resulting submatrices to the final splits array
#   splits.concat(submatrix_splits) unless submatrix_splits.empty?
# end

                


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

# Example usage:
arr1 = [0, 1, 2]
arr2 = [0, 1, 2]
combinations1 = generate_combinations(arr1)
combinations2 = generate_combinations(arr2)


splits = []
# splits = split_matrix(matrix, [], [0, 1])
combinations1.each do |com1|
  combinations2.each do |com2|
    # puts "#{com1.inspect},\t #{com2.inspect}"
    split = split_matrix(matrix, com1, com2)
    if one_resin_per_piece?(split)
      splits << split
    end
  end
end


# def do_the_task(matrix, rows, ind, max_len, rows_to_split, splits)
#   split = []
#   if ind == max_len - 1
#     return
#   end
#   (ind..max_len-1).each do |i|
#     # puts i
#     # rows.push(i) if rows.index(i) == nil
#     # rows = rows.uniq()
#     # puts rows.inspect
#     rows_to_split.push(i)
#     split = split_matrix_rows(matrix, rows_to_split)
#     # puts "split #{split.inspect}"
#     if one_resin_per_piece?(split)
#       # puts "returned"
#       splits << split.dup
#       if ind != 0
#         return splits
#       end
#     end
    
#     temp_rows_to_split = rows_to_split.dup
#     # puts temp_rows_to_split.inspect
#     # puts rows_to_split.inspect
#     splits << do_the_task(matrix, rows, ind + 1, max_len, temp_rows_to_split, splits)

#   end
#   if ind == 0
#     return splits
#   else
#     return nil
#   end
# end




# rows = [0, 1, 2, 3]
# ind = 0
# max_len = 4
# rows_to_split = []
# splits = []

# splits = do_the_task(matrix, rows, ind, max_len, rows_to_split, splits)

# puts one_resin_per_piece?(splits)

splits.each do |array|
  puts one_resin_per_piece?(array)
  array.each do |list|
    print_matrix(list)
    puts "\n"
  end
  puts "==========\n"
end