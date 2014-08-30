#!/usr/bin/env ruby
# Depth First Search
# Determine if there is a triangle in a given graph (3 node cycle)

graph = {'A'=>['B', 'C', 'E'],
        'B'=> ['A', 'D', 'F'],
        'C'=> ['A', 'G', 'E'],
        'D'=> ['B'],
        'E'=> ['A','F', 'C'],
        'F'=> ['B', 'E'],
        'G'=> ['C']
      }

class DepthFirst
  def dfs(graph, start, visited=[])
    visited << start
    graph[start].each do |node|
      unless visited.include?(node)
        return 'triangle in graph' if (graph[node] & graph[start]).size == 1
        dfs(graph, node, visited) 
      end
    end
    return visited
  end
end

search = DepthFirst.new
p search.dfs(graph, 'A')
