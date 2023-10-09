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
arr1 = [0, 1, 2, 3]
arr2 = [0, 1, 2, 3, 4, 5, 6, 7]
combinations1 = generate_combinations(arr1)
combinations2 = generate_combinations(arr2)
puts combinations1.inspect
puts "\n"
puts combinations2.inspect