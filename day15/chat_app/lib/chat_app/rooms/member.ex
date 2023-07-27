defmodule ChatApp.Rooms.Member do
  use Ecto.Schema
  import Ecto.Changeset

  alias ChatApp.Accounts.Account
  alias ChatApp.Rooms.Room

  schema "members" do
    belongs_to(:account, Account)
    belongs_to(:room, Room)

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(member, attrs) do
    cast(member, attrs, [:account_id, :room_id])
  end
end
