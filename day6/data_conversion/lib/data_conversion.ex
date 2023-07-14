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
  def json_get(end_point_api) do
    [data, _] = end_point_api
    |> HTTPoison.get!
    |> Map.get(:body)
    |> Jason.decode!

    # Listを返す
    data
  end

  def json_encode!(string_lists) do
    Enum.map(string_lists, & String.split(&1, ","))
    # List
    |> Enum.map(fn [name, lon, lat] -> %{name: name, lon: lon, lat: lat} end)
    # BitStringを返す
    |> Jason.encode!
  end

  def gets(data) do
    # 要素を引数として下の関数を呼び出す
    Enum.map(data, & get(&1))
  end

  def get(head) do
    lat = head["設置地点"]["地理座標"]["軽度"]
    lon = head["設置地点"]["地理座標"]["緯度"]
    [h | _t] = head["設置地点"]["名称"]
    name = h["表記"]

    # 取得したデータを文字列として返す
    "#{name},#{lon},#{lat}"
  end
end
