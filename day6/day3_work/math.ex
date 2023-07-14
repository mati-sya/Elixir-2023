defmodule Math do
  def done(n) do
    n
    |> multiplication
    |> multiplication
    |> multiplication
  end

  def multiplication(n) do
    n * 2
  end

  def multiplication(x, y) do
    x * y
  end
end
