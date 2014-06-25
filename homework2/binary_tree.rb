class BinaryTree
  attr_accessor :root
  
  def initialize(root = nil)
    @root = root
  end

  def search(value)
    search_for_node(@root,Node.new(value))
  end

  def insert(value)
    @root = insert_value(@root,value)
  end

  def delete(value)
    @root = delete_node(@root,Node.new(value))
  end

  def in_order_list
      vals = []
       inorder(vals,@root)
      vals
  end

  def traverse_tree(node)
    unless node.nil?
      traverse_tree(node.left)
      process_item(node)
      traverse_tree(node.right)
    end
  end

  def get_nodes(container, node, weight)
    unless node.nil?
      get_nodes(container, node.left, weight)
      left_over = process_best_fit(node, weight)
      return container.push(left_over) unless left_over.nil?
      get_nodes(container, node.right, weight)
    end
  end

  def process_best_fit(node, weight)
    if node.value - weight.weight >= 0
      node
    end
  end

  def process_item(node)
    puts "Remaining Space in Bin: " + node.value.to_s
  end
    
private
  def search_for_node(root,node)
      if root.nil?
         return nil
      end

      if root == node
         root = node
      elsif node < root
         root = search_for_node(root.left,node)
      else
         root = search_for_node(root.right,node)
      end
     root
  end

  def insert_value(root,value)
    if root.nil?
      root = Node.new(value)
    elsif value < root.value               
      root.left = insert_value(root.left,value)          
    else
      root.right = insert_value(root.right,value)
    end
   root
  end

 def delete_node(root,node)
      if root == node
         root = remove(root)
      elsif node < root
         root.left = delete_node(root.left,node)
      else
         root.right = delete_node(root.right,node)
      end
     root
  end

  def remove(node)
    if node.left.nil? && node.right.nil?
       node = nil
    elsif !node.left.nil? && node.right.nil?
       node = node.left
    elsif node.left.nil? && !node.right.nil?
       node = node.right
    else
       node = replace_parent(node)
    end
   node
  end

 def replace_parent(node)
       node.value = successor_value(node.right)
       node.right = update(node.right)
       node
  end

  def successor_value(node)
      unless node.left.nil?
        successor_value(node.left)
      end
      node.value
  end

  def update(node)
      unless node.left.nil?
        node.left = update(node)
      end
      node.right
  end

  def inorder(list, node)
    unless node.nil?
       inorder(list, node.left)
       list.push(node.value)
       inorder(list, node.right)
    end
  end
end