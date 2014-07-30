#!/usr/bin/env ruby
#Kruskal's algorithm

class UnionFind
  def initialize(n)
    @leaders = 1.upto(n).inject([]) { |leaders, i| leaders[i] = i; leaders }
  end
  
  def connected?(id1,id2)
    @leaders[id1] == @leaders[id2]
  end
  
  def union(id1,id2)
    leader_1, leader_2 = @leaders[id1], @leaders[id2]
    @leaders.map! {|i| (i == leader_1) ? leader_2 : i }
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

set = UnionFind.new edges.size

edges.each do |edge|
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