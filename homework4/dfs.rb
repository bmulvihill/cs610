#!/usr/bin/env ruby
# Depth First Search
require 'set'
graph = {'A'=>['B', 'C', 'E'],
        'B'=> ['A', 'D', 'F'],
        'C'=> ['A', 'G'],
        'D'=> ['B'],
        'E'=> ['A'],
        'F'=> ['B', 'E'],
        'G'=> ['C']
      }

class DepthFirst
  def dfs(graph, start, visited=[])
    visited << start
    graph[start].each do |node|
      dfs(graph, node, visited) unless visited.include?(node)
    end
    return visited
  end
end

search = DepthFirst.new
p search.dfs(graph, 'A')