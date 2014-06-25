#!/usr/bin/env ruby
# Accepts Array
# Returns only unique elements
# Uses mergesort checks for unique elements and only returns them
# O(n log n) complexity
class UniqueSelect
	def self.get_unique_elements(keys=[])
		sorted_keys = QuickSort.sort!(keys)
		sorted_keys.each do |key|
			if key == key+1

			end
		end
	end

end

class MergeSort
	def self.mergesort(list)
	  return list if list.size <= 1
	  mid = list.size / 2
	  left  = list[0, mid]
	  right = list[mid, list.size-mid]
	  merge(mergesort(left), mergesort(right))
	end

	def self.merge(left, right)
	  sorted = []
	  until left.empty? or right.empty?
	    if left.first == right.first
	    	right = right - [right.first]
	    elsif left.first <= right.first
	      sorted << left.shift
	    else
	      sorted << right.shift
	    end
	  end
	  sorted.concat(left).concat(right)
	end
end

p MergeSort.mergesort([3,3,5,1,8,7,2,4,1,1,1,1,2])