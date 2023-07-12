defmodule Example do
  def hello_world do
    IO.inspect("Hello, World")
  end

  def matching(num) do
    case num do
      n when n in [1,3,4,6,7] -> "Not Found"
      n when n in [2,5] -> "Matched!"
    end
  end

  def func(n) when is_integer(n) do
    n + 1
  end
end
