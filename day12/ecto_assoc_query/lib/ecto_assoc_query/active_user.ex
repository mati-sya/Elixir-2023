defmodule EctoAssocQuery.ActiveUser do
  use Ecto.Schema

  schema "active_users" do
    belongs_to :user, EctoAssocQuery.User
  end
end
