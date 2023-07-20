defmodule ApiToEcto.Places do
  alias ApiToEcto.Repo
  alias ApiToEcto.Place
  import Ecto.Query

  # すべてのデータを取得する関数の作成
  def get_places() do
    Repo.all(Place)
  end

  # idでデータを取得する関数の作成
  def get_place(id) when is_integer(id) do
    Repo.get(Place, id)
  end

  # idがIntegerじゃない場合nilを返す
  def get_place(_id), do: nil

  # データを挿入する関数の作成
  # 引数 place = Place構造体, e.g. %Place{name: "12345", address: "東京都練馬区"}
  def create_place(place) do
    Repo.insert(place)
  end

  # データを更新する関数の作成
  # 引数place = 挿入しているデータ
  # 引数params = 変更内容のデータ(map)
  def update_place(place, params) do
    cs = Place.changeset(place, params)
    Repo.update(cs)
  end

  # データを削除する関数の作成
  def delete_place(id) when is_integer(id) do
    place = Repo.get(Place, id)

    if place != nil do
      Repo.delete(place)
    else
      nil
    end
  end

  def delete_place(_id), do: nil

  # クエリを使用して絞り込んでから取得する
  # e.g. name 131200002001
  def get_place_by_name(name \\ "131200002001") do
    query = from(p in Place, where: p.name == ^name)
    # クエリから1つのデータを取得する関数
    Repo.one(query)
  end

  # クエリのセレクトを使用して特定のカラムの値のみを取得する
  def select_address() do
    query = from(p in Place, select: p.address)
    Repo.all(query)
  end

  # アドレス検索
  def get_places_to_search_by_address(address) do
    # SQL pattern
    pattern = "%#{address}%"
    query = from(p in Place, where: like(p.address, ^pattern))
    Repo.all(query)
  end

  def ad_search() do
    get_places_to_search_by_address("石神井台")
  end

  # ---
end
