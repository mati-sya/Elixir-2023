defmodule EctoTransaction.GetItem do
  use Ecto.Schema

  schema "get_items" do
    belongs_to :user, EctoTransaction.User
    belongs_to :item, EctoTransaction.Item
  end
end
