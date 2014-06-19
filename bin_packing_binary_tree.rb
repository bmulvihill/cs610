module BinaryTree
  class Node
    include Comparable
    attr_accessor :left, :right, :parent, :value
    
    def initialize(value)
      @value = value
    end

    def <=>(otherNode)
      @value <=> otherNode.value
    end
  end

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
      puts node.value
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

  class Weight
    attr_accessor :weight
    def initialize(weight)
      @weight = weight
    end
  end

  class BestFitBinPacking
    def self.execute(weights=[])
      # TESTING DATA #
      weight1 = Weight.new(0.5)
      weight2 = Weight.new(0.6)
      weight3 = Weight.new(0.7)
      weight4 = Weight.new(0.4)
      weights = [weight1, weight2, weight4, weight3]
      # TESTING DATA #
      tree = BinaryTree.new
      bin_count = 0

      weights.each do |weight|
        nodes =[]
        nodes = tree.get_nodes([], tree.root, weight)
        if nodes == [] || nodes.nil?
          bin_count += 1
          tree.insert(1)
          nodes = tree.get_nodes([], tree.root, weight)
        end

        best_fit = nodes.first
        new_value = best_fit.value - weight.weight
        if new_value == 0
          tree.delete(best_fit.value)
        else
          tree.delete(best_fit.value)
          tree.insert(new_value)
        end
      end
      p "TOTAL BINS: " + bin_count.to_s
      tree.traverse_tree(tree.root)
    end
  end
  
  class WorstFitBinPacking
    def self.execute(weights=[])
      # TESTING DATA #
      weight1 = Weight.new(0.5)
      weight2 = Weight.new(0.6)
      weight3 = Weight.new(0.7)
      weight4 = Weight.new(0.4)
      weights = [weight1, weight2, weight4, weight3]
      # TESTING DATA #
      tree = BinaryTree.new
      bin_count = 0
      
      weights.each do |weight|
        nodes =[]
        nodes = tree.get_nodes([], tree.root, weight)
        if nodes == [] || nodes.nil?
          bin_count += 1
          tree.insert(1)
          nodes = tree.get_nodes([], tree.root, weight)
        end

        worst_fit = nodes.last
        new_value = worst_fit.value - weight.weight
        if new_value == 0
          tree.delete(worst_fit.value)
        else
          tree.delete(worst_fit.value)
          tree.insert(new_value)
        end
      end
      p "TOTAL BINS: " + bin_count.to_s
      tree.traverse_tree(tree.root)     
    end
  end
end