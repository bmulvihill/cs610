
#!/usr/bin/env ruby
# Take an array of values and return the median element
# Must be done is O(n) time
class MedianSelect
  
  def self.sort!(keys=[])
    median_element = (keys.size-1)/2
    p quick(keys,0,keys.size-1, median_element)
  end
 
  private
 
  def self.quick(keys, left, right, median_element)
    if left < right
      pivot_index = (left + ((right - left) / 2)).to_i
      pivot_index = partition(keys, left, right, pivot_index)
      if pivot_index == median_element
        return keys[pivot_index]
      elsif median_element < pivot_index
        return quick(keys, left, pivot_index-1, median_element)
      else
        return quick(keys, pivot_index+1, right, median_element)
      end
    end
  end
 
  def self.partition(keys, left, right, pivot)
    pivotValue = keys[pivot]
    keys[pivot], keys[right] = keys[right], keys[pivot]  
    storeIndex = left 
    for i in left..right -1 
      if keys[i] < pivotValue
        keys[storeIndex], keys[i] = keys[i], keys[storeIndex]
        storeIndex += 1
      end
    end
    keys[right], keys[storeIndex] = keys[storeIndex], keys[right]  
    return storeIndex
  end
end

MedianSelect.sort!([1,6,8,2,4,10,0])