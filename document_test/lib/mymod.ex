defmodule MyMod do
  @moduledoc """
  Add one to an integer and string number
  """

  @doc """
  my_func(n) : Add one to an integer number

      ## Exsample

      ```

      iex> MyMod.my_func(3)

      4

      ```
  """
  def my_func(n) when is_integer(n) do
    n + 1
  end

  @doc """
  my_funcs(str):Add one to an String number

      ## Exsample

      ```
      iex> MyMod.my_funcs("100")

      101

      ```
  """
  def my_funcs(str) when is_binary(str) do
    # StringをIntegerに変換する
    case Integer.parse(str) do
      {n, ""} -> n + 1
      _ -> raise(ArgumentError)
    end
  end
end
