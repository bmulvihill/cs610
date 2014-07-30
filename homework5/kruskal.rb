#!/usr/bin/env ruby
#Kruskal's algorithm

class UnionFind
  def initialize(n)
    @forests = 1.upto(n).inject([]) { |forests, i| forests[i] = i; forests }
  end
  
  def connected?(vertex1,vertex2)
    @forests[vertex1] == @forests[vertex2]
  end
  
  def union(vertex1,vertex2)
    @forests.map! {|i| (i == @forests[vertex1]) ? @forests[vertex2] : i }
  end
end



@minimum_spanning_tree = []

edges = [
  {:vertices => [1,3], :weight => 2},
  {:vertices => [1,4], :weight => 4},
  {:vertices => [2,3], :weight => -5},
  {:vertices => [2,4], :weight => -3},
  {:vertices => [2,5], :weight => 1},
  {:vertices => [3,4], :weight => -2}
].sort_by { |e| e[:weight] }

subset = edges[0..2]
set = UnionFind.new subset.size

subset.each do |edge|
  if !set.connected?(edge[:vertices][0], edge[:vertices][1]) || edge[:weight] < 0
    @minimum_spanning_tree << edge 
    set.union(edge[:vertices][0], edge[:vertices][1])
  end  
end

puts "MST:"
  @minimum_spanning_tree.each do |edge|
    puts "Edge: " + edge[:vertices][0].to_s + ',' + edge[:vertices][1].to_s
    puts "Weight: " + edge[:weight].to_s
  end

puts "Total Cost: #{@minimum_spanning_tree.inject(0) { |acc, x| acc + x[:weight]}}"