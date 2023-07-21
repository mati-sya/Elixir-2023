defmodule EctoAssocQuery.DeleteUser do
  use Ecto.Schema

  schema "delete_users" do
    belongs_to :user, EctoAssocQuery.User
  end
end
