defmodule ApiToEcto.Place do
  use Ecto.Schema
  import Ecto.Changeset

  schema "places" do
    field :name, :string
    field :address, :string
    field :lat, :float
    field :lon, :float

    timestamps()
  end

  def changeset(place, params \\ %{}) do
    place
    # Applies the given params as changes on the data according to the set of permitted keys. Returns a changeset.
    |> cast(params, [:name, :address, :lat, :lon])
    # validation
    |> validate_required([:name, :address, :lat, :lon])
    |> validate_required(:name, message: "Please set a name.")
    # validate name
    |> unique_constraint([:name, :address], message: "A place with this name has already been registered.")
    |> unsafe_validate_unique(:name, ApiToEcto.Repo, message: "A place with this address has already been registered.")
  end
end
