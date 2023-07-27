defmodule ChatApp.Rooms.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias ChatApp.Accounts.Account

  schema "rooms" do
    field :room_name, :string

    timestamps()

    many_to_many(:accounts, Account, join_through: "members")
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:room_name])
    |> validate_required([:room_name])
  end
end
