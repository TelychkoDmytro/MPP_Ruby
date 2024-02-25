class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinaryTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    @root = insert_recursive(@root, value)
  end

  def search(value)
    search_recursive(@root, value)
  end

  def delete(value)
    @root = delete_recursive(@root, value)
  end

  def inorder_traversal
    inorder_traversal_recursive(@root)
  end

  private

  def insert_recursive(node, value)
    return Node.new(value) if node.nil?

    if value < node.value
      node.left = insert_recursive(node.left, value)
    elsif value > node.value
      node.right = insert_recursive(node.right, value)
    end

    node
  end

  def search_recursive(node, value)
    return nil if node.nil? || node.value == value

    if value < node.value
      search_recursive(node.left, value)
    else
      search_recursive(node.right, value)
    end
  end

  def delete_recursive(node, value)
    return node if node.nil?

    if value < node.value
      node.left = delete_recursive(node.left, value)
    elsif value > node.value
      node.right = delete_recursive(node.right, value)
    else
      if node.left.nil?
        return node.right
      elsif node.right.nil?
        return node.left
      end

      node.value = find_min_value(node.right)
      node.right = delete_recursive(node.right, node.value)
    end

    node
  end

  def find_min_value(node)
    current_node = node
    current_node = current_node.left until current_node.left.nil?
    current_node.value
  end

  def inorder_traversal_recursive(node)
    return [] if node.nil?

    result = []
    result.concat(inorder_traversal_recursive(node.left))
    result << node.value
    result.concat(inorder_traversal_recursive(node.right))

    result
  end
end

# Приклад використання
binary_tree = BinaryTree.new
binary_tree.insert(5)
binary_tree.insert(3)
binary_tree.insert(7)
binary_tree.insert(2)
binary_tree.insert(4)

puts "Inorder Traversal: #{binary_tree.inorder_traversal}"  # Виведе: Inorder Traversal: [2, 3, 4, 5, 7]

search_result = binary_tree.search(3)
puts "Search Result for 3: #{search_result&.value}"  # Виведе: Search Result for 3: 3

binary_tree.delete(3)
puts "Inorder Traversal after deleting 3: #{binary_tree.inorder_traversal}"  # Виведе: Inorder Traversal after deleting 3: [2, 4, 5, 7]
