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
  def json_get(end_point_api \\ "https://api.data.metro.tokyo.lg.jp/v1//WifiAccessPoint") do
    [data, _] =
      end_point_api
      |> HTTPoison.get!()
      |> Map.get(:body)
      |> Jason.decode!()

    # Listを返す
    data
  end

  def json_encode!(string_lists) do
    Enum.map(string_lists, &String.split(&1, ","))
    # List
    |> Enum.map(fn [name, lon, lat] -> %{name: name, lon: lon, lat: lat} end)
    # BitStringを返す
    |> Jason.encode!()
  end

  def gets(data) do
    # 要素を引数として下の関数を呼び出す
    Enum.map(data, &get(&1))
  end

  def get(head) do
    lat = head["設置地点"]["地理座標"]["軽度"]
    lon = head["設置地点"]["地理座標"]["緯度"]
    [h | _t] = head["設置地点"]["名称"]
    name = h["表記"]

    # 取得したデータをStringとして返す
    "#{name},#{lon},#{lat}"
  end

  # MapのListを引数として渡す
  def create_csv(map_list, filename \\ "new.csv") do
    data =
      CSV.encode(map_list, headers: true)
      |> Enum.map(& &1)
      # リストを外し、文字列に変換
      |> Enum.join()

    # lat,lon,nameのデータをcsvファイルに書き込む
    File.write!(filename, data)
  end

  def read_csv(path) do
    # File.Stream
    file = File.stream!(path)
    # Stream
    CSV.decode!(file, headers: true)
    # StreamをMapのListにする
    |> Enum.map(& &1)
  end
end
