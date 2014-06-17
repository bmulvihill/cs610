module BinaryTree
  class Node
    attr_accessor :left, :right, :parent, :value, :size
    def initialize(value)
      @value = value
      @size = 1.0
    end
  end

  class BinaryTree
    attr_accessor :root, :nodes
    
    def initialize(root)
      @root = root
      @nodes =[]
    end

    def insert_node(root, node)
      if node.value < root.value
        return root.left = node, node.parent = root if root.left.nil?
        return insert_node(root.left,node)
      else
        return root.right = node, node.parent = root if root.right.nil?
        return insert_node(root.right, node)
      end
    end

    def delete_node(root, node)
      if root.value == node.value
         root = remove(root)
      elsif node.value < root.value
         root.left = delete_node(root.left,node)
      else
         root.right = delete_node(root.right,node)
      end
      root
    end

    def traverse_tree(node)
      unless node.nil?
        traverse_tree(node.left)
        process_item(node)
        traverse_tree(node.right)
      end
    end

    def set_nodes(node, weight)
      unless node.nil?
        set_nodes(node.left, weight)
        process_best_fit(node, weight)
        set_nodes(node.right, weight)
      end
    end

    def process_best_fit(node, weight)
      if node.size - weight.weight >= 0
        @nodes << node
      end
    end

    def process_item(node)
      puts node.size
    end

    def search_tree(node, item)
      return if node.nil?
      return node if node.value == item
      if item < node.value
        return search_tree(node.left, item)
      else
        return search_tree(node.right, item)
      end
    end
    
    def find_minimum
      return if @root.nil?
      min = @root
      while min.left != nil
        min = min.left
      end
      return min
    end

    def find_maximum
      return if @root.nil?
      max = @root
      while max.right != nil
        max = max.right
      end
      return max
    end
    
    private
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
  end

  class Weight
    attr_accessor :weight
    def initialize(weight)
      @weight = weight
    end
  end


  class BestFitBinPacking
    def self.execute
      weight1 = Weight.new(0.5)
      weight2 = Weight.new(0.2)
      weight3 = Weight.new(1.0)
      weight4 = Weight.new(0.4)
      weights = [weight1, weight3, weight2, weight4]
      tree = BinaryTree.new(Node.new(1))
      bin_count = 1
      weights.each do |weight|
        tree.nodes = []
        tree.set_nodes(tree.root, weight)
        if tree.nodes == []
          bin_count += 1
          tree.insert_node(tree.root, Node.new(2))
          tree.set_nodes(tree.root, weight)
        end
        nodes = tree.nodes
        best_fit = nodes.sort_by {|node| node.size - weight.weight }.first
        best_fit.size = best_fit.size - weight.weight
      end
      p "TOTAL BINS: " + bin_count.to_s
      tree.traverse_tree(tree.root)
    end
  end
  
  class WorstFitBinPacking
    def self.execute
      weight1 = Weight.new(0.5)
      weight2 = Weight.new(0.6)
      weight3 = Weight.new(0.3)
      weight4 = Weight.new(0.4)
      weights = [weight1, weight3, weight2, weight4]
      tree = BinaryTree.new(Node.new(1))
      bin_count = 1
      weights.each do |weight|
        tree.nodes = []
        tree.set_nodes(tree.root, weight)
        if tree.nodes == []
          bin_count += 1
          tree.insert_node(tree.root, Node.new(2))
          tree.set_nodes(tree.root, weight)
        end
        nodes = tree.nodes
        worst_fit = nodes.sort_by {|node| node.size - weight.weight }.last
        worst_fit.size = worst_fit.size - weight.weight
      end
      p "TOTAL BINS: " + bin_count.to_s
      tree.traverse_tree(tree.root)       
    end
  end
end