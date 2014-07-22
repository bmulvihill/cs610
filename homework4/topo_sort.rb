#!/usr/bin/env ruby
# Performs topographical sort using Tarjan's algorithm
require 'tsort'

class TsortHash < Hash
  include TSort
  alias tsort_each_node each_key
  def tsort_each_child(node, &block)
    fetch(node).each(&block)
  end
end

graph = 
  TsortHash[ 
    {
      :a =>[], 
      :b =>[:a], 
      :c =>[:b, :e], 
      :d =>[:a, :b],
      :e =>[:d, :b],
      :f =>[:c, :e, :g],
      :g =>[:d, :e, :h],
      :h =>[:f],
      :i =>[:g],
      :j =>[:i, :h]
      } ]

  p graph.tsort