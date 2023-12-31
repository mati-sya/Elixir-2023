defmodule ApiToEcto do
  alias ApiToEcto.Place

  @moduledoc """
  Documentation for `ApiToEcto`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ApiToEcto.hello()
      :world

  """
  def api_call(api \\ "https://api.data.metro.tokyo.lg.jp/v1/WifiAccessPoint") do
    [data, _] =
      api
      # Data type = HTTPoison.response
      |> HTTPoison.get!()
      # Data type = BitString
      |> Map.get(:body)
      # Data type = List (最初の要素；MapのList→dataに束縛)
      |> Jason.decode!()

    # MapのListを返す
    data
  end

  def gets(data), do: Enum.map(data, &get(&1))

  # headのdata type = Map（関数getsの中で呼び出される関数)
  def get(h) do
    # Mapのデータを変数に束縛
    [name | _] = h["設置地点"]["名称"]

    # 取得したデータをPlaces構造体に保存
    %Place{
      name: name["表記"],
      address: h["設置地点"]["住所"]["表記"],
      lat: String.to_float(h["設置地点"]["地理座標"]["経度"]),
      lon: String.to_float(h["設置地点"]["地理座標"]["緯度"])
    }
  end

  ## DAY8 WORK, DAY9 WORK
  def get_csv(path \\ "lat_lon.csv") do
    # data type = File.Stream
    file = File.stream!(path)
    # data type = Stream
    CSV.decode!(file, headers: true)
    # StreamをMapのListにする
    |> Enum.map(& &1)
    # Enum.mapで関数get_dataを呼び出してPlacesのリストを返す
    |> Enum.map(fn x -> get_data(x) end)
  end

  defp get_data(map) do
    %Place{
      name: map["大字町丁目コード"],
      address: map["都道府県名"] <> map["市区町村名"] <> map["大字町丁目名"],
      lat: String.to_float(map["緯度"]),
      lon: String.to_float(map["経度"])
    }
  end
end
