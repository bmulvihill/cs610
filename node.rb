class Node
  include Comparable
  attr_accessor :left, :right, :parent, :value
  
  def initialize(value)
    @value = value
  end

  def <=>(otherNode)
    @value <=> otherNode.value
  end
end