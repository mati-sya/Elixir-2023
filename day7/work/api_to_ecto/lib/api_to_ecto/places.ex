defmodule ApiToEcto.Places do
  alias ApiToEcto.Repo
  alias ApiToEcto.Place

  # すべてのデータを取得する関数の作成
  def get_places() do
    Repo.all(Place)
  end

  # idでデータを取得する関数の作成
  def get_place(id) do
    if is_integer(id) do
      Repo.get(Place, id)
    else
      nil
    end
  end

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
  def delete_place(id) do
    if is_integer(id) do
      place = Repo.get(Place, id)
      if place != nil do
        Repo.delete(place)
      else
        nil
      end
    else
      nil
    end
  end

end
