defmodule Example.User do
  use Ecto.Schema

    schema "users" do
      field :first_name, :string
      field :last_name, :string
      field :age, :integer

      # inserted_at, updated_at colums
      timestamps()
    end
end
