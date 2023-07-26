defmodule HouseholdAccountBookApp.Incomes.Income do
  use Ecto.Schema
  import Ecto.Changeset

  schema "incomes" do
    field :date, :date
    field :money, :integer

    timestamps()
  end

  @doc false
  def changeset(income, attrs) do
    income
    |> cast(attrs, [:money, :date])
    |> validate_required([:money, :date])
  end
end
