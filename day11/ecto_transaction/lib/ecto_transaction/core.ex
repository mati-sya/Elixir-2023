defmodule EctoTransaction.Core do
  alias EctoTransaction.{Repo, User, Point, PointLog, Item, GetItem}
  # Ecto.Multi documentation: https://hexdocs.pm/ecto/Ecto.Multi.html
  alias Ecto.Multi
  import Ecto.Query

  # params例： %{name: "Taro", email: "taro@example.com"}
  def create_user(params) do
    # make empty Multi struct
    Multi.new()
    # add operation with keyword :user
    |> Multi.insert(:user, User.changeset(%User{}, params))
    # add operation with keyword :point
    |> Multi.insert(:point, fn %{user: user} ->
      Point.changeset(%Point{user: user}, %{point_balance: 1000})
    end)
    # add operation with keyword :point_log
    |> Multi.insert(:point_log, fn %{user: user} ->
      PointLog.changeset(%PointLog{user: user}, %{
        category: "give",
        amount: 1000,
        point_balance: 1000
      })
    end)
    # execute operations
    |> Repo.transaction()
  end

  def buy_item(user_id, item_id) do
    # get User struct from DB with user ID
    user =
      Repo.get(User, user_id)
      # "unpack" user points
      |> Repo.preload(:point)

    # get Item from DB
    item = Repo.get(Item, item_id)

    if user && item do
      # make new Multi struct
      Multi.new()
      # add operation :get_item
      |> Multi.insert(:get_item, %GetItem{user: user, item: item})
      # add update operation :point
      # (not using insert because of the 1 vs 1 relation between :users and :points)
      |> Multi.update(:point, fn _ ->
        # pointsテーブルのpoint_balanceにアイテムのポイントを引いた値を束縛
        point_balance = user.point.point_balance - item.price
        Point.changeset(user.point, %{point_balance: point_balance})
      end)
      # add operation :point_log
      |> Multi.insert(:point_log, fn %{point: point} ->
        PointLog.changeset(%PointLog{user: user}, %{
          category: "use",
          amount: item.price,
          point_balance: point.point_balance
        })
      end)
      # execute operations
      |> Repo.transaction()
    else
      nil
    end
  end

  def delete_user(user_id) do
    Multi.new()
    # Ecto.Multi内で実行する機能を追加
    # 必ず{:ok, value}か{:error, value}を返す必要がある
    # 第3引数：関数を指定（関数が受け取る引数は2つあり、1つ目はEcto.Repoを受け取り、2つ目にEcto.Multiでこれまで変更した内容を受け取ります。）
    |> Multi.run(:user, fn repo, _changes ->
      case repo.get(User, user_id) do
        nil -> {:error, :not_found}
        user -> {:ok, user}
      end
    end)
    # adds deletion operation to the Multi struct
    |> Multi.delete(:point, fn %{user: user} ->
      query = from(p in Point, where: p.user_id == ^user.id)
      Repo.one(query)
    end)
    # adds delete_all operation to the multi
    |> Multi.delete_all(:point_logs, fn %{user: user} ->
      from(pl in PointLog, where: pl.user_id == ^user.id)
    end)
    |> Multi.delete_all(:get_items, fn %{user: user} ->
      from(gi in GetItem, where: gi.user_id == ^user.id)
    end)
    |> Multi.delete(:delete_user, fn %{user: user} -> user end)
    |> Repo.transaction()
  end
end
