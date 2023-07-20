defmodule EctroTransaction.Point do
  use Ecto.Schema
  import Ecto.Changeset

  schema "points" do
    field :point_balance, :integer, default: 0
    belongs_to :user, EctoTransaction.User
  end

  def changeset(point, params) do
    point
    |> cast(params, [:point_balance])
    |> validate_required(:point_balance, message: "Please enter your point balance.")
  end
end
