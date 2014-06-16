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

		def search_tree(node, item)
			return if node.nil?
			return node if node.value == item
			if item < node.value
				return search_tree(node.left, item)
			else
				return search_tree(node.right, item)
			end
		end

	end

	class TestTree
		def self.search
			node1 = Node.new(1)
			node2 = Node.new(5)
			node3 = Node.new(-10)
			node4 = Node.new(2)
			tree = BinaryTree.new(node1)
			tree.insert_node(tree.root, node2)
			tree.insert_node(tree.root, node3)
			tree.insert_node(tree.root, node4)
			p tree.search_tree(tree.root, -10)
		end

	end
end