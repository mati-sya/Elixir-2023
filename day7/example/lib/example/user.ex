defmodule Example.User do
  use Ecto.Schema
  # https://hexdocs.pm/ecto/Ecto.Changeset.html
  import Ecto.Changeset

    schema "users" do
      field :first_name, :string
      field :last_name, :string
      field :age, :integer

      # inserted_at, updated_at colums
      timestamps()
    end

    def changeset(user, params \\ %{}) do
      user
      # Applies the given params as changes on the data according to the set of permitted keys. Returns a changeset.
      |> cast(params, [:first_name, :last_name, :age])
      # Validates that one or more fields are present in the changeset.
      |> validate_required([:first_name, :last_name])
    end
end
