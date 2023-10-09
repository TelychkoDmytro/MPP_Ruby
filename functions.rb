module functions
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
end
