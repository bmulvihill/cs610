module BinaryTree
	class Node
		attr_accessor :left, :right, :parent, :value
		def initialize(value)
			@value = value
		end
	end

	class BinaryTree
		attr_reader :root
		
		def initialize(root)
			@root = root
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

		def process_item(node)
			puts node.value
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


	class TestTree
		def self.search
			node1 = Node.new(1)
			node2 = Node.new(5)
			node3 = Node.new(-10)
			node4 = Node.new(2)
			node5 = Node.new(6)
			tree = BinaryTree.new(node1)
			tree.insert_node(tree.root, node2)
			tree.insert_node(tree.root, node3)
			tree.insert_node(tree.root, node4)
			tree.insert_node(tree.root, node5)
			#p tree.search_tree(tree.root, 10)
			#p tree.find_minimum
			#p tree.find_maximums
			#p tree.traverse_tree(tree.root)
			tree.delete_node(tree.root, node2)
			p tree.traverse_tree(tree.root)
			#p tree.search_tree(tree.root, -10)
		end

	end
end