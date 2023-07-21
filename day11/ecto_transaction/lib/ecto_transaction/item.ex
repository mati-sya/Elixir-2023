defmodule EctoTransaction.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :price, :integer, default: 0
    has_many :get_items, EctoTransaction.GetItem
    has_many :users, through: [:get_items, :user]
  end

  def changeset(item, params) do
    item
    |> cast(params, [:name, :price])
    |> validate_required(:name, message: "Please enter your name.")
    |> validate_required(:price, message: "Please enter your price.")
  end
end
