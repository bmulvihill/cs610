#!/usr/bin/env ruby
# Depth First Search

graph = {'A'=>[['B',6], ['C',1], ['E',2]],
        'B'=> [['A',6], ['D',2], ['F',4]],
        'C'=> [['A',1], ['G',3], ['E',2]],
        'D'=> [['B',2]],
        'E'=> [['A',2],['F',4], ['C',2]],
        'F'=> [['B',1], ['E',4]],
        'G'=> [['C',3]]
      }

class DepthFirst
  attr_reader :minimum_path, :minimum_cost
  def initialize
    @minimum_cost = 100 #Infinity
    @minimum_path = {}
    @depth = 1
  end

  def dfs(graph, start, finish, depth, visited=[], current_path=[], current_cost=0)
    visited << start
    if depth == 0
      if start == finish
        #if current_cost < @minimum_cost
          @minimum_path = current_path + [start] 
          #@minimum_cost[start] = current_cost 
        #end
      end
      return
    end

    graph[start].each do |node|
      unless visited.include?(node[0])
        dfs(graph, node[0], finish, depth - 1, visited, current_path + [start], current_cost + node[1])
      end
    end
    return visited
  end
end

search = DepthFirst.new
p search.dfs(graph, 'A', 'E', 2)
p search.minimum_path
p search.minimum_cost
