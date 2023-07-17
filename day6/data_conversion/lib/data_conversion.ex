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
  # end_point_apiのData type = String
  def json_get(end_point_api \\ "https://api.data.metro.tokyo.lg.jp/v1//WifiAccessPoint") do
    [data, _] =
      end_point_api
      # Data type = HTTPoison.response
      |> HTTPoison.get!()
      # Data type = BitString
      |> Map.get(:body)
      # Data type = List (最初の要素；MapのList→dataに束縛)
      |> Jason.decode!()
    # MapのListを返す
    data
  end

  # string_listsのData type = StringのList
  def json_encode!(string_lists) do
    # List: [["公衆電話（品川区東八潮1）No.1", "35.6251", ""], ...
    Enum.map(string_lists, &String.split(&1, ","))
    # ListのListをMapのListにする: [%{name: "公衆電話（品川区東八潮1）No.1", lon: "35.6251", lat: ""}, ...
    |> Enum.map(fn [name, lon, lat] -> %{name: name, lon: lon, lat: lat} end)
    # エンコーディングしてBitStringを返す
    |> Jason.encode!()
  end

  # dataのdata type = MapのList(json_getの返り値)
  def gets(data) do
    # getを呼び出してList内のMapをStringにする
    Enum.map(data, &get(&1))
  end

  # headのdata type = Map（関数getsの中で呼び出される関数)
  defp get(head) do
    # Mapのlatとlonとheadの表記データを変数に束縛
    lat = head["設置地点"]["地理座標"]["軽度"]
    lon = head["設置地点"]["地理座標"]["緯度"]
    [h | _t] = head["設置地点"]["名称"]
    name = h["表記"]

    # 取得したデータをStringとして返す
    "#{name},#{lon},#{lat}"
  end

  # map_list data type = MapのList
  # ①list = DataConversion.json_get |> DataConversion.gets
  # ②DataConversion.json_encode!(list) |> Jason.decode!
  def create_csv(map_list, filename \\ "new.csv") do
    data =
      CSV.encode(map_list, headers: true)
      |> Enum.map(& &1)
      # リストを外し、文字列に変換
      |> Enum.join()

    # lat,lon,nameのデータをcsvファイルに書き込む
    File.write!(filename, data)
  end

  # pathのdata type = String
  def read_csv(path) do
    # data type = File.Stream
    file = File.stream!(path)
    # data ype = Stream
    CSV.decode!(file, headers: true)
    # StreamをMapのListにする
    # Mapのキー："lat", "lon", "name"
    |> Enum.map(& &1)
  end
end
