defmodule DataConversion do
  @moduledoc """
  Documentation for `DataConversion`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> DataConversion.hello()
      :world

  """
  def read_csv(path) do
    File.read!(path)
  end

  def csv_to_map(data) do
    [header | values] = data
    |> String.split("\r\n")

    field = String.split(header, ",")

    Enum.map(values, fn value ->
      String.split(value, ",")
      # 無名関数：(fn x1, x2 -> Enum.zip(x2, x1) end)
      # 引数：field
      |> (&Enum.zip(&2, &1)).(field)
      # Mapにする
      |> Enum.into(%{})
    end)
  end

  def csv_decode(path) do
    file = File.stream!(path)
    CSV.decode!(file, headers: true)
    |> Enum.map(& &1)
  end

  def map_to_jason(map_data) do
    Jason.encode!(map_data)
  end

  def create_csv(map_data, filename) do
    # Map list
    map_data
    |> CSV.encode(headers: true)
    |> Enum.map(& &1)
    |> Enum.join()
    |> (&File.write!("#{filename}.csv", &1)).()
  end

  def create_jason(map_data, filename) do
    # Map list
    map_data
    |> Jason.encode!
    |> (&File.write!("#{filename}.jason", &1)).()
  end
end
