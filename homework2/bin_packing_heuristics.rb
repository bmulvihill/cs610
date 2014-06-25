require 'node'
require 'binary_tree'
require 'weight'

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
    full_count = 0

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
        full_count += 1
      else
        tree.delete(best_fit.value)
        tree.insert(new_value)
      end
    end
    p "TOTAL BINS USED: " + bin_count.to_s
    p "TOTAL BINS FILLED: " + full_count.to_s
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
    full_count = 0
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
        full_count += 1
      else
        tree.delete(worst_fit.value)
        tree.insert(new_value)
      end
    end
    p "TOTAL BINS USED: " + bin_count.to_s
    p "TOTAL BINS FILLED: " + full_count.to_s
    tree.traverse_tree(tree.root)     
  end
end
