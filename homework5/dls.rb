#!/usr/bin/env ruby
# Depth Limited Search
# Find the minimum cost/path on a graph given a start node, end node and set distance to travel

graph = {'A'=>[['B',6], ['C',1], ['E',2]],
        'B'=> [['A',6], ['D',2], ['F',4]],
        'C'=> [['A',1], ['G',3], ['E',2]],
        'D'=> [['B',2]],
        'E'=> [['A',2],['F',4], ['C',2]],
        'F'=> [['B',1], ['E',4]],
        'G'=> [['C',3]]
      }

class DepthLimited
  attr_reader :minimum_path, :minimum_cost
  def initialize
    @minimum_cost = 1000 #Infinity
    @minimum_path = {}
  end

  def dls(graph, start, finish, depth, current_path=[], current_cost=0)
    if depth == 0
      if start == finish
        if current_cost < @minimum_cost
          @minimum_path = current_path + [start] 
          @minimum_cost = current_cost 
        end
      end
      return
    end

    graph[start].each do |node|
      unless current_path.include?(node[0])
        dls(graph, node[0], finish, depth - 1, current_path + [start], current_cost + node[1])
      end
    end
  end
end

search = DepthLimited.new
search.dls(graph, 'A', 'F', 2)
p search.minimum_path
p search.minimum_cost
