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
  def read_csv(path \\ "132209_open_data_list.csv") do
    # returns BitString (file content)
    File.read!(path)
  end

  # data -> BitString (return value of read_csv)
  def csv_to_map(data) do
    # List of Strings
    [header | values] =
      data |> String.split("\n") #windows: \r\n

    # List of Strings (splitted header)
    field = String.split(header, ",")

    # apply fn ... end to every element in list "values"
    Enum.map(values, fn value -> # value -> element in values
      String.split(value, ",")
      # 無名関数：(fn x1, x2 -> Enum.zip(x2, x1) end)
      # 引数：value, field {"headline", "value"}
      |> (&Enum.zip(&2, &1)).(field)
      # Mapにする %{"headline" => "value", ...}
      |> Enum.into(%{})
    end)
  end

  # path -> String, path to csv file
  def csv_decode(path) do
    # data type = File.Stream
    file = File.stream!(path)
    # data type = Stream
    CSV.decode!(file, headers: true)
    # StreamをMapのListにする
    |> Enum.map(& &1)
  end

  # map_data -> List of Map (e.g., return value of csv_decode)
  def map_to_jason(map_data) do
    # returns BitString
    Jason.encode!(map_data)
  end

  # map_data -> List of Map, filename -> String
  def create_csv(map_data, filename) do
    # Map list
    map_data
    # returns Function
    |> CSV.encode(headers: true)
    # returns String List
    |> Enum.map(& &1)
    # returns BitString
    |> Enum.join()
    # writes and saves csv file, returns Atom :ok
    |> (&File.write!("#{filename}.csv", &1)).()
  end

  # map_data -> List of Map, filename -> String
  def create_jason(map_data, filename) do
    # returns Map list
    map_data
    # returns BitString
    |> Jason.encode!
    # writes and saves csv file, returns Atom :ok
    |> (&File.write!("#{filename}.jason", &1)).()
  end
end
