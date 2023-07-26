defmodule HouseholdAccountBookApp.Purchases.Purchase do
  use Ecto.Schema
  import Ecto.Changeset
  alias HouseholdAccountBookApp.Purchases.Category

  schema "purchases" do
    field :date, :date
    field :money, :integer
    field :name, :string
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(purchase, attrs) do
    purchase
    |> cast(attrs, [:name, :money, :date, :category_id])
    |> validate_required([:name, :money, :date])
  end
end
