defmodule Length do
def of([]), do: 0
def of([_ | tail]), do: 1 + of(tail)
end

# Length.of([])
# Length.of([1, 2, 3])
# Length.of([10,20,30,40,50,100])

defmodule Add1 do
  def of([]), do: []
  def of([head | tail]), do: [head + 1 | of(tail)]
end

# Add1.of([5, 6, 7])

defmodule Myfunc do
  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]
end

# Myfunc.map [5,6,7], fn n -> n+1 end

defmodule Goukei do
  def sum([], total), do: total
  def sum([head | tail], total), do: sum(tail, head + total)
end

# Goukei.sum([1, 2, 3, 4, 5], 0)

defmodule Swapper do
  def swap([]), do: []
  def swap([a, b | tail]), do: [b, a | swap(tail)]
  def swap([_]), do: raise("Can't swap.Odd number.")
end

# Swapper.swap [1, 2, 3, 4, 5, 6]
# Swapper.swap [1, 2, 3, 4, 5,6, 7]

defmodule Earnings do
  def for_location_20([]), do: []

  def for_location_20([[time, 20, temp, rain] | tail]) do
    [[time, 20, temp, rain] | for_location_20(tail)]
  end

  def for_location_20([_ | tail]), do: for_location_20(tail)
end

# import Earnings
# for_location_20([ [3213131, 20, 12, 0.125],[3213155, 21, 17, 0.2],[3213110, 8, 22, 0.5] ])
