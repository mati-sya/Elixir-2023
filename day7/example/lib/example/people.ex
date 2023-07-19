defmodule Example.People do
  use Ecto.Schema
  # https://hexdocs.pm/ecto/Ecto.Changeset.html
  import Ecto.Changeset

  schema "people" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:sns_address, :string)
    field(:tel, :string)

    # inserted_at, updated_at colums
    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    # cast & validate_required = Ecto.Changeset functions
    # [cast] Applies the given params as changes on the data according to the set of permitted keys. Returns a changeset.
    |> cast(params, [:first_name, :last_name, :sns_address, :tel])
    # Validates that one or more fields are present in the changeset.
    |> validate_required([:first_name, :last_name])
    |> validate_sns_address()
  end

  # cs = changeset
  defp validate_sns_address(cs) do
    cs
    |> validate_required(:sns_address, message: "Please enter your email.")
    # Checks for a unique constraint in the given field or list of fields.
    |> unique_constraint(:sns_address, message: "Email has already been retrieved.")
    # Validates that no existing record with a different primary key has the same values for these fields.
    |> unsafe_validate_unique(:sns_address, Example.Repo, message: "Email has already been retrieved.")
    |> validate_format(:sns_address, ~r/^[^\s]+@[^\s]+$/,
      message: "Must include the @ symbol, do not include spaces."
    )
  end

  def sample_changeset(user, params \\ %{}) do
    user
    |> cast(params, [:first_name, :last_name, :age])
    # add message as option (in case of invalidity this message is displayed in the error list)
    |> validate_required(:first_name, message: "Please enter your first name.")
    |> validate_required(:last_name, message: "Please enter your last name.")
  end
end
